// Given a 3d position as a seed, compute a smooth procedural noise
// value: "Perlin Noise", also known as "Gradient noise".
//
// Inputs:
//   st  3D seed
// Returns a smooth value between (-1,1)
//
// expects: random_direction, smooth_step
float perlin_noise( vec3 st) 
{
  vec3 rand1 = floor(st);
  vec3 rand2 = fract(st);
  vec3 smoth = smooth_step(rand2);
  // 3D so cube so 8 corners i think
  // orig to right below bottom to right above bottom to left above bottom to left above top to right above top to right below top to orig +1

  vec3 cor1 = vec3(0.0, 0.0, 0.0);
  vec3 cor2 = vec3(1.0, 0.0, 0.0);
  vec3 cor3 = vec3(1.0, 1.0, 0.0);
  vec3 cor4 = vec3(0.0, 1.0, 0.0);
  vec3 cor5 = vec3(0.0, 1.0, 1.0);
  vec3 cor6 = vec3(1.0, 1.0, 1.0);
  vec3 cor7 = vec3(1.0, 0.0, 1.0);
  vec3 cor8 = vec3(0.0, 0.0, 1.0);

  vec3 dir_cor1 = random_direction(rand1 + cor1);
  vec3 dir_cor2 = random_direction(rand1 + cor2);
  vec3 dir_cor3 = random_direction(rand1 + cor3);
  vec3 dir_cor4 = random_direction(rand1 + cor4);
  vec3 dir_cor5 = random_direction(rand1 + cor5);
  vec3 dir_cor6 = random_direction(rand1 + cor6);
  vec3 dir_cor7 = random_direction(rand1 + cor7);
  vec3 dir_cor8 = random_direction(rand1 + cor8);

  vec3 frac_cor1 = rand2 - cor1;
  vec3 frac_cor2 = rand2 - cor2;
  vec3 frac_cor3 = rand2 - cor3;
  vec3 frac_cor4 = rand2 - cor4;
  vec3 frac_cor5 = rand2 - cor5;
  vec3 frac_cor6 = rand2 - cor6;
  vec3 frac_cor7 = rand2 - cor7;
  vec3 frac_cor8 = rand2 - cor8;

  //to 2d on x 
  float new2dcor1 = mix(dot(dir_cor1, frac_cor1), dot(dir_cor2, frac_cor2), smoth.x); //orig
  float new2dcor2 = mix(dot(dir_cor4, frac_cor4), dot(dir_cor3, frac_cor3), smoth.x); //right bot on y
  float new2dcor3 = mix(dot(dir_cor5, frac_cor5), dot(dir_cor6, frac_cor6), smoth.x); // right top 
  float new2dcor4 = mix(dot(dir_cor8, frac_cor8), dot(dir_cor7, frac_cor7), smoth.x); // left top

  //to 1d on y
  float new1dcor1 = mix(new2dcor1, new2dcor2, smoth.y);
  float new1dcor2 = mix(new2dcor4, new2dcor3, smoth.y);

  // to 0d on z
  float newfinal = mix(new1dcor1, new1dcor2, smoth.z);

  newfinal = clamp(newfinal, -1.0, 1.0);
  return newfinal;

  
}

