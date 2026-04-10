#include <flutter/runtime_effect.glsl>

uniform float uTime;
uniform vec2 uSize;
uniform float uYaw;
uniform float uPitch;
uniform vec3 uHitPoint;
uniform float uHitIntensity;
uniform sampler2D uLandMask; 

out vec4 fragColor;

// --- Optimized Math ---
float hash(float n) { return fract(sin(n) * 43758.5453123); }

float noise(vec3 x) {
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;
    return mix(mix(mix(hash(n+0.0), hash(n+1.0),f.x),
                   mix(hash(n+57.0), hash(n+58.0),f.x),f.y),
               mix(mix(hash(n+113.0), hash(n+114.0),f.x),
                   mix(hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
}

// Simplified FBM (Reduced to 2 octaves for mobile stability)
float fbm(vec3 p) {
    float f = 0.500 * noise(p); 
    p *= 2.02;
    f += 0.250 * noise(p);
    return f / 0.75;
}

void main() {
    vec2 uv = (FlutterFragCoord().xy * 2.0 - uSize.xy) / min(uSize.x, uSize.y);
    
    vec3 ro = vec3(0.0, 0.0, 2.5);
    vec3 rd = normalize(vec3(uv, -1.5));
    
    float b = dot(ro, rd);
    float c = dot(ro, ro) - 1.0;
    float h = b*b - c;
    
    vec3 finalColor = vec3(0.01, 0.02, 0.05); // Deep background base
    float alpha = 0.2;
    
    if (h > 0.0) {
        float t = -b - sqrt(h);
        vec3 p = ro + t * rd;
        
        // Rotation
        float sy = sin(uYaw); float cy = cos(uYaw);
        vec3 pRot = vec3(p.x * cy + p.z * sy, p.y, -p.x * sy + p.z * cy);
        float sx = sin(uPitch); float cx = cos(uPitch);
        pRot = vec3(pRot.x, pRot.y * cx - pRot.z * sx, pRot.y * sx + pRot.z * cx);

        // Map to UV for mask
        vec2 polar = vec2(atan(pRot.z, pRot.x), acos(-pRot.y));
        vec2 landUV = vec2(polar.x / 6.2831 + 0.5, polar.y / 3.1415);
        float land = texture(uLandMask, landUV).r;

        // Optimized Layers
        float cloud = fbm(pRot * 1.5 + uTime * 0.1);
        vec3 col = mix(vec3(0.0, 0.1, 0.3), vec3(0.1, 0.6, 1.0), land);
        col += vec3(0.0, 0.4, 0.8) * cloud * 0.5;
        
        // Fresnel
        float fresnel = pow(1.0 - max(0.0, dot(p, -rd)), 3.0);
        col += vec3(0.3, 0.7, 1.0) * fresnel;
        
        // Interaction
        float hit = smoothstep(0.4, 0.0, distance(pRot, uHitPoint));
        col += vec3(1.0, 0.5, 0.2) * hit * uHitIntensity * 2.0;

        finalColor = col;
        alpha = mix(0.3, 0.9, land + fresnel * 0.5);
    }
    
    fragColor = vec4(finalColor * alpha, alpha);
}
