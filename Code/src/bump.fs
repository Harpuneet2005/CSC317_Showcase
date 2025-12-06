// Set the pixel color using Blinn-Phong shading (e.g., with constant blue and
// gray material color) with a bumpy texture.
// 
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
//                     linearly interpolated from tessellation evaluation shader
//                     output
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
//               rgb color of this pixel
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{

  float angle2 = M_PI*animation_seconds* 0.5; //moon speed
  float mon = mix(0.0, 1.0, is_moon);
    
  vec3 pos2 = sphere_fs_in;
  float x_rot = cos(angle2) * pos2.x + sin(angle2) * pos2.z; 
  float y_rot = pos2.y;
  float z_rot = cos(angle2) * pos2.z - sin(angle2) * pos2.x;
  vec3 pos_rotate = vec3(x_rot, y_rot, z_rot);

  pos2 = mix(pos2, pos_rotate, mon);

  // vec3 pos = sphere_fs_in;
  vec3 viewww = normalize(-view_pos_fs_in.xyz);

  vec3 norm = normalize(pos2);
  vec3 tang;
  vec3 bitang;
  tangent(norm, tang, bitang);

  vec3 pospos = bump_position(is_moon, pos2);
  vec3 post = bump_position(is_moon, normalize(pos2 + 0.05*tang));
  vec3 posb = bump_position(is_moon, normalize(pos2 + 0.05*bitang));

  vec3 bump = cross((post - pospos), (posb - pospos));
  vec3 normbump = normalize(bump);
  vec4 normbump4 = vec4(normbump, 0.0); 

  mat4 moon = model(is_moon, animation_seconds);
  vec4 bumpview = (view * moon) * normbump4;
  vec3 normbumpview = normalize(bumpview.xyz);

  float angle = M_PI*animation_seconds* 0.25;

  vec3 lightpos3 = vec3(10*cos(angle), 7, 10*sin(angle));
  vec4 lightpos4 = vec4(lightpos3, 1.0);
  vec4 lightview4 = view * lightpos4;
  vec3 lightview3 = lightview4.xyz;

  vec3 lig = normalize(lightview3 - view_pos_fs_in.xyz);

  vec3 white = vec3(1.0, 1.0, 1.0);


  vec3 dark_blue = vec3(0.0, 0.0, 1.0);
  vec3 darK_green = vec3(0.0, 1.0, 0.0);
  vec3 light_grey = vec3(0.75, 0.75, 0.75);
  vec3 dark_grey = vec3(0.05, 0.05, 0.05);


  
  
  // float pearl = perlin_noise(pos);
  // pearl = clamp(0.5*pearl + 0.5, 0.0, 1.0);

  float pearl1 = improved_perlin_noise(pos2);
  float pearl2 = improved_perlin_noise(pos2 * 2.0);
  float pearl3 = improved_perlin_noise(pos2 * 4.0);
  float pearl = pearl1 - pearl2 + pearl3;
  pearl = clamp(0.5*pearl + 0.4, 0.0, 1.0);


  vec3 color_earth = mix(dark_blue, darK_green, pearl);
  vec3 color_moon = mix(dark_grey, light_grey, pearl);

  vec3 diffuse = mix(color_earth, color_moon, mon);
  vec3 ambient = white;
  vec3 specular = mix(white, light_grey, mon);
  float pp = mix(200.0, 50.0, mon);

  color = blinn_phong(ambient, diffuse, specular, pp, normbumpview, viewww, lig);
}
