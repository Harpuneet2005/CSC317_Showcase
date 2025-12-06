// Filter an input value to perform a smooth step. This function should be a
// cubic polynomial with smooth_step(0) = 0, smooth_step(1) = 1, and zero first
// derivatives at f=0 and f=1. 
//
// Inputs:
//   f  input value
// Returns filtered output value
float smooth_step( float f)
{
  float ff = f*f;
  float fff = f*f*f;
  return 3.0*ff - 2.0*fff;
}

vec3 smooth_step( vec3 f)
{
  vec3 ff = f*f;
  vec3 fff = f*f*f;
  return 3.0*ff - 2.0*fff;
}
