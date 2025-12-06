// Filter an input value to perform an even smoother step. This function should
// be a quintic polynomial with improved_smooth_step(0) = 0,
// improved_smooth_step(1) = 1, and zero first _and_ second derivatives at f=0
// and f=1. "Improving Noise" [Perlin 2002].
//
// Inputs:
//   f  input value
// Returns filtered output value
float improved_smooth_step( float f)
{
  float f3 = f*f*f;
  float f4 = f3*f;
  float f5 = f4*f;
  
  return 6.0*f5 - 15*f4 + 10*f3;
}
vec3 improved_smooth_step( vec3 f)
{
  vec3 f3 = f*f*f;
  vec3 f4 = f3*f;
  vec3 f5 = f4*f;
  
  return 6.0*f5 - 15*f4 + 10*f3;
}
