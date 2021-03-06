#version 330 core

// Interpolated values from the vertex shaders
in vec2 uv;

// Ouput data

// Values that stay constant for the whole mesh.
uniform sampler2D myTextureSampler;

out vec3 color;

void main(){

    // Output color = color of the texture at the specified UV
    color = texture( myTextureSampler, uv ).rgb;
}
