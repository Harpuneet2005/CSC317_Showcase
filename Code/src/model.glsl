// Construct the model transformation matrix. The moon should orbit around the
// origin. The other object should stay still.
//
// Inputs:
//   is_moon  whether we're considering the moon
//   time  seconds on animation clock
// Returns affine model transformation as 4x4 matrix
//
// expects: identity, rotate_about_y, translate, PI

uniform int count_ring;
uniform int index_ring;

// mat4 model(bool is_moon, float time)
// {
//   mat4 id = identity();
//   float angle = M_PI*time*0.5;
//   vec3 orbit = vec3(2.0, 0.0, 0.0);
//   float size = 0.3;
  
//   mat4 trans = rotate_about_y(angle) * translate(orbit) * uniform_scale(size);
//   // float moon = float(is_moon);
//   float moon = mix(0.0, 1.0, is_moon);

//   return id + moon*(trans - id);
// }


mat4 model(bool is_moon, float time)
{
  mat4 id = identity();

  float index = float(index_ring);
  float num = max(1.0, float(count_ring));

  float angstart = M_PI*2.0*(index/num);

  //basically just random2 but i couldnt figure out how to use it here without errors
  float randrand = fract(sin(index)*43758.5453123);
  randrand = randrand * 0.5 - 0.25;
  float radd = 2.0 + randrand;
  
  float randrand2 = fract(sin(index + 5.0)*43758.5453123);
  randrand2 = (randrand2 * 0.5 - 0.25) * 0.5;
  float heightt = randrand2;

  float randrand3 = fract(sin(index + 10.0)*43758.5453123);
  randrand3 = (randrand3 * 0.05) + 0.025;
  //float size = randrand3;
  float size = 2.5;


  float angle = (M_PI*time*0.5);
  vec3 orbit = vec3(0.0, 0.0, heightt);
  mat4 makearing = identity();
  makearing[1][1] = 0.0;
  mat4 trans = rotate_about_y(angle) * translate(orbit) * makearing * uniform_scale(size);
  // float moon = float(is_moon);
  float moon = mix(0.0, 1.0, is_moon);

  return id + moon*(trans - id);
}
