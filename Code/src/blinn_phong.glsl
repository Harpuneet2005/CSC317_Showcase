// Compute Blinn-Phong Shading given a material specification, a point on a
// surface and a light direction. Assume the light is white and has a low
// ambient intensity.
//
// Inputs:
//   ka  rgb ambient color
//   kd  rgb diffuse color
//   ks  rgb specular color
//   p  specular exponent (shininess)
//   n  unit surface normal direction
//   v  unit direction from point on object to eye
//   l  unit light direction
// Returns rgb color
vec3 blinn_phong(
  vec3 ka,
  vec3 kd,
  vec3 ks,
  float p,
  vec3 n,
  vec3 v,
  vec3 l)
{
  vec3 ambient = 0.15 * ka;
  
  float nl = dot(n, l);
  nl = clamp(nl, 0.0, 1.0);
  vec3 diffuse = kd * nl;

  vec3 lv = l+ v;
  vec3 halfvec = normalize(lv);
  float nh = dot(n, halfvec);
  nh = clamp(nh, 0.0, 1.0);

  // float is_nl = mix(0.0, 1.0/nl, nl);
  // float spec_part1 = pow(nh, p) * is_nl;

  float spec_part1 = pow(nh, p) * nl; //might be an issue, but well see
  vec3 specular = ks * spec_part1;

  return ambient + diffuse + specular;

}


