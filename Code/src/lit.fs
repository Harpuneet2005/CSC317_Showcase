// Add (hard code) an orbiting (point or directional) light to the scene. Light
// the scene using the Blinn-Phong Lighting Model.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: PI, blinn_phong
void main()
{
  float angle = M_PI*animation_seconds* 0.25;
  // vec3 orbit = vec3(10.0, 0.0, 0.0);
  // mat4 trans = rotate_about_y(angle) * translate(orbit);   Why cant we have nice things in life. why do i have to do this calc again

  // vec4 orig = vec4(0.0, 0.0, 0.0, 1.0);
  // vec4 lightpos4 = (trans * orig);
  // vec3 lightpos3 = lightpos4.xyz;
  // vec4 lightview4 = view * lightpos4;
  // vec3 lightview3 = lightview4.xyz;w

  vec3 lightpos3 = vec3(10*cos(angle), 7, 10*sin(angle));
  vec4 lightpos4 = vec4(lightpos3, 1.0);
  vec4 lightview4 = view * lightpos4;
  vec3 lightview3 = lightview4.xyz;


  vec3 norm = normalize(normal_fs_in);
  vec3 viewww = normalize(-view_pos_fs_in.xyz);
  vec3 lig = normalize(lightview3 - view_pos_fs_in.xyz);
  vec3 ambient = vec3(0.2,0.2,0.2);
  vec3 diffuse = mix(vec3(0.0,0.0,1.0) ,vec3(0.5,0.5,0.5), vec3(is_moon, is_moon, is_moon));
  vec3 spec = vec3(1,1,1);

  color = blinn_phong(ambient, diffuse, spec, 1000, norm, viewww, lig);

}
