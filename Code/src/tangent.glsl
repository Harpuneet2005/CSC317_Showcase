// Input:
//   N  3D unit normal vector
// Outputs:
//   T  3D unit tangent vector
//   B  3D unit bitangent vector
void tangent(in vec3 N, out vec3 T, out vec3 B)
{
  //vec3 orig = vec3(0.0, 0.0, 0.0);
  vec3 xpoint = vec3(1.0, 0.0, 0.0);
  vec3 ypoint = vec3(0.0, 1.0, 0.0);
  vec3 zpoint = vec3(0.0, 0.0, 1.0);

  bool axis_select = (abs(N.z) >= (1.0 - 0.0001));

  vec3 axis = vec3(0.0, 0.0, 0.0);
  axis.x = mix(zpoint.x, ypoint.x, axis_select);
  axis.y = mix(zpoint.y, ypoint.y, axis_select);
  axis.z = mix(zpoint.z, ypoint.z, axis_select);

  vec3 tang = cross(axis, N);
  T = normalize(tang);

  vec3 bitan = cross(N, T);
  B = normalize(bitan);

  /////////////////////////////////////////////////////////////////////////////
} //from the assignment github page on getting T and B from N
