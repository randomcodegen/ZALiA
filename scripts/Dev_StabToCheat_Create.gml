/// Dev_StabToCheat_Create()

var _i,_j;

SPR_CAND = spr_Item_Candle; // 
SPR_GLOV = spr_Item_Glove; // 
SPR_HAMM = spr_Item_Hammer; // 
SPR_RAFT = spr_Item_Raft; // 
SPR_BOOT = spr_Item_Boots; // 
SPR_FLUT = spr_Item_Flute; // 
SPR_CROS = g.SPR_ITEM_CROSS; // 
SPR_MKEY = spr_Item_Magical_Key; // 

SPR_THDW = spr_arrow_6_dwn; // 
SPR_THUP = spr_arrow_6_up; // 

SPR_SPEL = spr_icon_bottle_1a; // 

SPR_HART = spr_Item_Heart_container; // 
SPR_MAGI = spr_Item_Magic_container; // 

SPR_LVLA = global.SPR_ICON_ATK; // 
SPR_LVLM = global.SPR_ICON_MAG; // 
SPR_LVLL = global.SPR_ICON_LIF; // 


SPR_KEY1 = spr_Item_Key; // 
SPR_PBAG = spr_Item_PBag; // 
SPR_BOTL = spr_Item_Bottle; // 

SPR_NOTE = spr_Item_Map; // 
SPR_TRPH = spr_Item_Trophy; // 
SPR_MIRR = spr_Item_Mirror; // 
SPR_MEDI = g.SPR_ITEM_MEDICINE; // 
SPR_CHLD = spr_Item_Child; // 
SPR_DOLL = val(g.dm_ITEM[?object_get_name(ItmG0)+'01'+STR_Sprite], spr_Item_LifeDoll_1a); // 


OPTION_CNT = $20;

dl_sprites=ds_list_create();
// Major Items
dl_sprites[|$00] = SPR_CAND; // 
dl_sprites[|$01] = SPR_GLOV; // 
dl_sprites[|$02] = SPR_RAFT; // 
dl_sprites[|$03] = SPR_BOOT; // 
dl_sprites[|$04] = SPR_FLUT; // 
dl_sprites[|$05] = SPR_CROS; // 
dl_sprites[|$06] = SPR_HAMM; // 
dl_sprites[|$07] = SPR_MKEY; // 
// Skills
dl_sprites[|$08] = SPR_THDW; // 
dl_sprites[|$09] = SPR_THUP; // 
// Spells
dl_sprites[|$0A] = SPR_SPEL; // 
dl_sprites[|$0B] = SPR_SPEL; // 
dl_sprites[|$0C] = SPR_SPEL; // 
dl_sprites[|$0D] = SPR_SPEL; // 
dl_sprites[|$0E] = SPR_SPEL; // 
dl_sprites[|$0F] = SPR_SPEL; // 
dl_sprites[|$10] = SPR_SPEL; // 
dl_sprites[|$11] = SPR_SPEL; // 
// Heart & Magic Containers
dl_sprites[|$12] = SPR_HART; // 
dl_sprites[|$13] = SPR_MAGI; // 
// Attack,Magic,Life Levels
dl_sprites[|$14] = SPR_LVLA; // 
dl_sprites[|$15] = SPR_LVLM; // 
dl_sprites[|$16] = SPR_LVLL; //
dl_sprites[|$17] = dl_sprites[|$14]; // 
dl_sprites[|$18] = dl_sprites[|$15]; // 
dl_sprites[|$19] = dl_sprites[|$16]; //
// Magic Refill Jar
dl_sprites[|$1A] = SPR_BOTL;
// P-Bags
dl_sprites[|$1B] = SPR_PBAG;
dl_sprites[|$1C] = dl_sprites[|$1B];
dl_sprites[|$1D] = dl_sprites[|$1B];
dl_sprites[|$1E] = dl_sprites[|$1B];
// Suicide
dl_sprites[|$1F] = spr_0; // For suicide.

// dl_sprites[|] = ; // 

// OBJ_CNT = array_length_1d(ar_spr);


for(_i=OPTION_CNT-1; _i>=0; _i--) ar_pi[_i]=0;
ar_pi[ 0] = get_pi(PI_MOB_ORG); // 
ar_pi[ 1] = get_pi(PI_MOB_ORG); // 
ar_pi[ 2] = get_pi(PI_MOB_ORG); // 
ar_pi[ 3] = get_pi(PI_MOB_ORG); // 
ar_pi[ 4] = get_pi(PI_MOB_ORG); // 
ar_pi[ 5] = get_pi(PI_MOB_ORG); // 
ar_pi[ 6] = get_pi(PI_MOB_ORG); // 
ar_pi[ 7] = get_pi(PI_MOB_ORG); // 

ar_pi[ 8] = get_pi(PI_PC_1); // 
ar_pi[ 9] = get_pi(PI_PC_1); // 

ar_pi[10] = get_pi(PI_MOB_BLU); // 
ar_pi[11] = get_pi(PI_MOB_BLU); // 
ar_pi[12] = get_pi(PI_MOB_BLU); // 
ar_pi[13] = get_pi(PI_MOB_BLU); // 
ar_pi[14] = get_pi(PI_MOB_BLU); // 
ar_pi[15] = get_pi(PI_MOB_BLU); // 
ar_pi[16] = get_pi(PI_MOB_BLU); // 
ar_pi[17] = get_pi(PI_MOB_BLU); // 

ar_pi[18] = get_pi(PI_MOB_RED); // 
ar_pi[19] = get_pi(PI_MOB_RED); // 

ar_pi[20] = get_pi(PI_GUI_1); // 
ar_pi[21] = get_pi(PI_GUI_1); // 
ar_pi[22] = get_pi(PI_GUI_1); //
ar_pi[23] = ar_pi[20];
ar_pi[24] = ar_pi[21];
ar_pi[25] = ar_pi[22];
ar_pi[26] = get_pi(PI_MOB_RED);
ar_pi[27] = get_pi(PI_MOB_ORG);
ar_pi[28] = get_pi(PI_MOB_ORG);
ar_pi[29] = get_pi(PI_MOB_ORG);
ar_pi[30] = get_pi(PI_MOB_ORG);

ar_pi[31] = get_pi(PI_PC_1); // suicide



is_active    = false;
// cheat_requested = false;
collided_cheat = false;
// can_activate_cheat = false;

cheat_num = 0;


SND_REMOVE = get_audio_theme_track(dk_GannonLaugh);
// SND_REMOVE = g.SND_PC_GRUNT1;


CLM_BASE = $18; // 
ROW_BASE = $18; // 
CLM_OFF  = $04; // 
ROW_OFF  = $02; // 
// X_BASE  =  $; // 
// Y_BASE  =  $; // 

Dev_StabToCheat_update_1a();




/*
0000 0000 >>2 = 00
0000 0100 >>2 = 0000 0001
0000 1100 >>2 = 0000 0011
0001 1000 >>2 = 0000 0110
0000 0000 >>2 = 00
0000 0000 >>2 = 00
0000 0000 >>2 = 00
0000 0000 >>2 = 00
0000 0000 >>2 = 00
*/
