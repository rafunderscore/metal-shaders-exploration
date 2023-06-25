//
//  Chromatic Abberation.metal
//  MetalShaderShowcases
//
//  Created by Raphael S on 24/06/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

[[ stitchable ]] half4 chromaticAbberation(float2 position, SwiftUI::Layer layer, float red, float green, float blue) {
    
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;
    
    new_color.r = layer.sample(position - float2(red, -red)).r;
    new_color.g = layer.sample(position - float2(green, -green)).g;
    new_color.b = layer.sample(position - float2(blue, -blue)).b;

    return new_color;
}

[[ stitchable ]] half4 chromaticAbberationTime(float2 position, SwiftUI::Layer layer, float time) {
    
    half4 current_color = layer.sample(position);
    half4 new_color = current_color;
    
    float amount = 0.0;
    
    amount = (1.0 + sin(time*6.0)) * 0.5;
    amount *= 1.0 + sin(time*16.0) * 0.5;
    amount *= 1.0 + sin(time*19.0) * 0.5;
    amount *= 1.0 + sin(time*27.0) * 0.5;
    
    amount = pow(amount, 3.0);

    amount *= 0.05;
    
    new_color.r = layer.sample(position + float2(amount/2, -amount/2)).r;
    new_color.g = layer.sample(position - float2(amount/2, -amount/2)).g;
    new_color.b = layer.sample(position - float2(amount/2, -amount/2)).b;
    
    new_color *= (1.0 - amount * 0.5);
    
    return new_color;
}
