// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height( bool is_moon, vec3 s)
{
  vec3 pos = normalize(s);

  float pearl1 = improved_perlin_noise(pos);
  float pearl2 = improved_perlin_noise(pos * 2.0);
  float pearl3 = improved_perlin_noise(pos * 4.0);
  float pearl = pearl1 - pearl2 + pearl3;
  pearl = clamp(pearl, -1.0, 1.0);

  float steep = mix(2.5, 7.5, is_moon);
  float heavi = smooth_heaviside(pearl, steep);
  
  float bumpiness = mix(0.075, 0.1, is_moon);

  float bump = heavi * bumpiness;
  bump = clamp(bump, -0.1, 0.1);

  return bump;
}
