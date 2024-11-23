/// Surface_init()


depth = DEPTH_SURFACE;

x = 0
y = 0;



//WW = application_surface_W;
//HH = application_surface_H;
//ww = WW;
//hh = HH;

//WW = view_wport[0];
//HH = view_hport[0];
//ww = WW;
//hh = HH;
//surface_resize(application_surface, WW,HH);


//srf_view_W = WW<<1;
//srf_view_H = HH<<1;
//srf_view = -1;
//view_surface_id[0] = srf_view;


timer = 0;


srf_frame_curr = 0;
srf_frame_prev = 0;



// draw_clear_color:  Will clear the screen right before 
// capturing an image of the application surface so 
// everything is a solid color.
// Must be set every frame as it will set itself to -1 
// after clearing the screen.
// -1 means will NOT call draw_clear()
draw_clear_color = p.C_BLK1; // First frame draw clear black


g.surf = id;




    RoomPreview_VER = 0;
if (RoomPreview_VER)
{
    RoomPreview_surf    = 0;
    //RoomPreview_state   = 0;
    RoomPreview_XL      = 0;
    RoomPreview_YT      = 0;
    RoomPreview_w       = PAGE_W;
    RoomPreview_h       = PAGE_H;
    RoomPreview_rm_name = RM_NAME_NPALACE;
    RoomPreview_KEY1    = vk_f2;
    RoomPreview_KEY2    = vk_f3;
}




//global.application_surface_draw_enable_STATE = true;

if (global.RetroShaders_IS_LIVE 
&&  shaders_are_supported() )
{
    shd_SaturationBrightness_IS_COMPILED = shader_is_compiled(shd_SaturationBrightness);
    shd_ScanLines01_IS_COMPILED          = shader_is_compiled(shd_ScanLines01);
    shd_Bloom01_IS_COMPILED              = shader_is_compiled(shd_Bloom01);
    shd_Blur01_IS_COMPILED               = shader_is_compiled(shd_Blur01);
    shd_Blur02_IS_COMPILED               = shader_is_compiled(shd_Blur02);
    
    if (shd_SaturationBrightness_IS_COMPILED 
    ||  shd_ScanLines01_IS_COMPILED 
    ||  shd_Bloom01_IS_COMPILED 
    ||  shd_Blur01_IS_COMPILED 
    ||  shd_Blur02_IS_COMPILED )
    {
        GEE = instance_create(0,0,GraphicsEffectsEditor);
    }
    else
    {
        //global.RetroShaders_enabled = false;
    }
}




/*
var _VAL1=$80000000;
var _VAL2=$800;
testval1=_VAL1-_VAL2;
testval2=_VAL1+_VAL2;
//testval1=-1024;
//testval2=-testval1;
//teststr1=undefined;
*/




