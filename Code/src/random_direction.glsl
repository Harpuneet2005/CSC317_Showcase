// Generate a pseudorandom unit 3D vector
// 
// Inputs:
//   seed  3D seed
// Returns psuedorandom, unit 3D vector drawn from uniform distribution over
// the unit sphere (assuming random2 is uniform over [0,1]²).
//
// expects: random2.glsl, PI.glsl
vec3 random_direction( vec3 seed)
{ 
  vec2 rand = random2(seed.xy);
  
  float z = 2.0*rand.x - 1.0;
  
  float angle = 2.0 * M_PI * rand.y;

  float zz = z*z;
  zz = 1.0 - zz;
  zz = clamp(zz, 0.0, 1.0);
  zz = pow(zz, 0.5);

  float x = zz * cos(angle);
  float y = zz * sin(angle);
  vec3 pos = vec3(x, y, z);
  return pos;
  
}
