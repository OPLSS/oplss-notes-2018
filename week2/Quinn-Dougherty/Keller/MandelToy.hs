{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE RebindableSyntax    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE ViewPatterns        #-}

module MandelToy where

import Data.Array.Accelerate                              as A
import Data.Array.Accelerate.IO                           as A
import Data.Array.Accelerate.Data.Complex                 as A
import Data.Array.Accelerate.Data.Colour.RGB              as A
import Data.Array.Accelerate.Data.Colour.Names            as A

--import Data.Array.Accelerate.LLVM.Native                  as CPU
-- import Data.Array.Accelerate.LLVM.PTX                     as PTX

import qualified Prelude                                  as P

mandelbrot
    :: Int                  -- ^ image width
    -> Int                  -- ^ image height
    -> Int                  -- ^ iteration limit
    -> Float                -- ^ divergence radius
    -> Complex Float        -- ^ view centre
    -> Float                -- ^ view width
    -> Acc (Array DIM2 (Complex Float, Int))
mandelbrot screenX screenY limit radius (x0 :+ y0) width =
  A.generate (A.constant (Z :. screenY :. screenX))
             (\ix -> let z0 = complexOfPixel ix
                         zn = while (\zi -> snd zi       < constant limit
                                         && dot (fst zi) < constant radius)
                                    (\zi -> step z0 zi)
                                    (lift (z0, constant 0))
                     in
                     zn)
  where
    -- Convert the given array index, representing a pixel in the final image,
    -- into the corresponding point on the complex plane.
    --
    complexOfPixel :: Exp DIM2 -> Exp (Complex Float)
    complexOfPixel (unlift -> Z :. y :. x) =
      let
          height = P.fromIntegral screenY / P.fromIntegral screenX * width
          xmin   = x0 - width  / 2
          ymin   = y0 - height / 2
          --
          re     = constant xmin + (fromIntegral x * constant width)  / constant (P.fromIntegral screenX)
          im     = constant ymin + (fromIntegral y * constant height) / constant (P.fromIntegral screenY)
      in
      lift (re :+ im)

    -- Divergence condition
    --
    dot :: Exp (Complex Float) -> Exp Float
    dot (unlift -> x :+ y) = x*x + y*y

    -- Take a single step of the recurrence relation
    --
    step :: Exp (Complex Float) -> Exp (Complex Float, Int) -> Exp (Complex Float, Int)
    step c (unlift -> (z, i)) = lift (next c z, i + constant 1)

    next :: Exp (Complex Float) -> Exp (Complex Float) -> Exp (Complex Float)
    next c z = c + z * z


-- Convert the iteration count on escape to a colour.
--
escapeToColour
    :: Int
    -> Exp (Complex Float, Int)
    -> Exp Colour
escapeToColour limit (unlift -> (z, n)) =
  if n == constant limit
    then black
    else ultra (toFloating ix / toFloating points)
      where
        mag     = magnitude z
        smooth  = logBase 2 (logBase 2 mag)
        ix      = truncate (sqrt (toFloating n + 1 - smooth) * scale + shift) `mod` points
        --
        scale   = 256
        shift   = 1664
        points  = 2048 :: Exp Int

-- Pick a nice colour, given a number in the range [0,1].
--
ultra :: Exp Float -> Exp Colour
ultra p =
  if p <= p1 then interp (p0,p1) (c0,c1) (m0,m1) p else
  if p <= p2 then interp (p1,p2) (c1,c2) (m1,m2) p else
  if p <= p3 then interp (p2,p3) (c2,c3) (m2,m3) p else
  if p <= p4 then interp (p3,p4) (c3,c4) (m3,m4) p else
                  interp (p4,p5) (c4,c5) (m4,m5) p
  where
    p0 = 0.0     ; c0 = rgb8 0   7   100  ; m0 = (0.7843138, 2.4509804,  2.52451)
    p1 = 0.16    ; c1 = rgb8 32  107 203  ; m1 = (1.93816,   2.341629,   1.6544118)
    p2 = 0.42    ; c2 = rgb8 237 255 255  ; m2 = (1.7046283, 0.0,        0.0)
    p3 = 0.6425  ; c3 = rgb8 255 170 0    ; m3 = (0.0,       -2.2812111, 0.0)
    p4 = 0.8575  ; c4 = rgb8 0   2   0    ; m4 = (0.0,       0.0,        0.0)
    p5 = 1.0     ; c5 = c0                ; m5 = m0

    -- interpolate each of the RGB components
    interp (x0,x1) (y0,y1) ((mr0,mg0,mb0),(mr1,mg1,mb1)) x =
      let
          RGB r0 g0 b0 = unlift y0 :: RGB (Exp Float)
          RGB r1 g1 b1 = unlift y1 :: RGB (Exp Float)
      in
      rgb (cubic (x0,x1) (r0,r1) (mr0,mr1) x)
          (cubic (x0,x1) (g0,g1) (mg0,mg1) x)
          (cubic (x0,x1) (b0,b1) (mb0,mb1) x)

-- cubic interpolation
cubic :: (Exp Float, Exp Float)
      -> (Exp Float, Exp Float)
      -> (Exp Float, Exp Float)
      -> Exp Float
      -> Exp Float
cubic (x0,x1) (y0,y1) (m0,m1) x =
  let
      -- basis functions for cubic hermite spine
      h_00 = (1 + 2*t) * (1 - t) ** 2
      h_10 = t * (1 - t) ** 2
      h_01 = t ** 2 * (3 - 2 * t)
      h_11 = t ** 2 * (t - 1)
      --
      h    = x1 - x0
      t    = (x - x0) / h
  in
  y0 * h_00 + h * m0 * h_10 + y1 * h_01 + h * m1 * h_11

-- linear interpolation
linear :: (Exp Float, Exp Float)
       -> (Exp Float, Exp Float)
       -> Exp Float
       -> Exp Float
linear (x0,x1) (y0,y1) x =
  y0 + (x - x0) * (y1 - y0) / (x1 - x0)


main :: P.IO ()
main =
  let
      width   = 800
      height  = 600
      limit   = 1000
      radius  = 256
      --
      img = A.map packRGB
          $ A.map (escapeToColour limit)
          $ mandelbrot width height limit radius ((-0.7) :+ 0) 3.067
  in
  writeImageToBMP "mandelbrot.bmp" (run img)
