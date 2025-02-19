shader_type canvas_item;

// 导出参数
uniform float light_intensity : hint_range(0.0, 5.0) = 1.0;
uniform vec2 light_position = vec2(0.5, 0.5);  // 光源位置（世界或屏幕坐标，取决于use_global_position）
uniform bool use_global_position = true;  // 是否使用全局坐标
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float light_radius : hint_range(0.0, 2000.0) = 200.0;  // 使用实际像素单位
uniform float falloff_intensity : hint_range(1.0, 10.0) = 2.0;
uniform float ambient_intensity : hint_range(0.0, 1.0) = 0.2;

void fragment() {
    // 获取纹理颜色
    vec4 tex_color = texture(TEXTURE, UV);
    
    // 计算像素到光源的距离 - 修复坐标系问题
    vec2 pixel_position;
    vec2 light_pos;
    
    if (use_global_position) {
        // 使用全局坐标系，需要将Fragment的坐标转换为全局坐标
        pixel_position = FRAGCOORD.xy;
        light_pos = light_position;
    } else {
        // 使用UV坐标系 (0.0-1.0)
        pixel_position = UV * TEXTURE_PIXEL_SIZE.xy;  // 转换UV到像素坐标
        light_pos = light_position * TEXTURE_PIXEL_SIZE.xy;  // 转换光源位置到像素坐标
    }
    
    float distance_to_light = length(pixel_position - light_pos);
    
    // 计算衰减因子 - 使用像素距离而非归一化距离
    float attenuation = 1.0 - smoothstep(0.0, light_radius, distance_to_light);
    attenuation = pow(attenuation, falloff_intensity);
    
    // 计算环境光
    vec3 ambient = tex_color.rgb * ambient_intensity;
    
    // 计算漫反射光
    vec3 diffuse = tex_color.rgb * light_color.rgb * attenuation * light_intensity;
    
    // 最终颜色 = 环境光 + 漫反射光
    vec3 final_color = ambient + diffuse;
    
    // 保持原始alpha通道
    COLOR = vec4(final_color, tex_color.a);
}