// Set the pixel color to blue or gray depending on is_moon.
//
// Uniforms:
uniform bool is_moon;
// Outputs:
out vec3 color;
void main()
{
  /////////////////////////////////////////////////////////////////////////////
  // Replace with your code:
  // vec3 blue = vec3(0.0,0.0,1.0);
  // vec3 grey = vec3(0.5,0.5,0.5);
  // float moon = mix(0.0, 1.0, is_moon);

  // color = (moon*grey) + (moon*blue);
  // color = vec3(0.5);
  color = mix(vec3(0.0,0.0,1.0) ,vec3(0.5,0.5,0.5), vec3(is_moon, is_moon, is_moon));
  /////////////////////////////////////////////////////////////////////////////
}
