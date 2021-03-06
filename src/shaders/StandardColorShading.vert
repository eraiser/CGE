#version 330 core

// Input vertex data, different for all executions of this shader.
in vec4 vertexPosition_modelspace;
in vec3 vertexColor;
in vec4 vertexNormal_modelspace;

// Output data ; will be interpolated for each fragment.
out vec3 VC;
out vec3 Position_worldspace;
out vec3 Normal_cameraspace;
out vec3 EyeDirection_cameraspace;
out vec3 LightDirection_cameraspace;

// Values that stay constant for the whole mesh.
uniform mat4 PVM;
uniform mat4 V;
uniform mat4 M;
uniform vec3 LightPosition_worldspace;

void main(){

	// Output position of the vertex, in clip space : PVM * position
	gl_Position =  PVM * vertexPosition_modelspace;
	
	// Position of the vertex, in worldspace : M * position
	Position_worldspace = (M * vertexPosition_modelspace).xyz;
	
	// Vector that goes from the vertex to the camera, in camera space.
	// In camera space, the camera is at the origin (0,0,0).
	vec3 vertexPosition_cameraspace = ( V * M * vertexPosition_modelspace).xyz;
	EyeDirection_cameraspace = vec3(0,0,0) - vertexPosition_cameraspace;

	// Vector that goes from the vertex to the light, in camera space. M is ommited because it's identity.
	vec3 LightPosition_cameraspace = ( V * vec4(LightPosition_worldspace,1)).xyz;
	LightDirection_cameraspace = LightPosition_cameraspace + EyeDirection_cameraspace;
	
	// Normal of the the vertex, in camera space
	Normal_cameraspace = ( V * M * vertexNormal_modelspace).xyz; // Only correct if ModelMatrix does not scale the model ! Use its inverse transpose if not.
	
	// UV of the vertex. No special space for this one.
	VC = vertexColor;
}

