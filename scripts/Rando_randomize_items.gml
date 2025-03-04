/// Rando_randomize_items()


//.........................................................
random_set_seed(Rando_SEED);
//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''


var _i,_j,_k,_m, _idx, _val;
var _count,_count1,_count2,_count3;
var _loc_num,_loc_num1,_loc_num2, _loc_cat,_loc_cat1;
var _qual_loc_count1,_qual_loc_count2;
var _is_item, _is_key;
var _item_id, _item_num, _key_id, _spell_id, _rm_name, _town_name, _spell_name;
var _something_was_placed = false;
var _rando_step=0;

placement_num=0;

CONTAINER_METHOD=3;

CONTROL_ALLKEY=2;
ALLKEY_LOC_NUM=0;
if (CONTROL_ALLKEY==1) var _ALLKEY_RANDOM_VALUE=irandom(99);
else                   var _ALLKEY_RANDOM_VALUE=0;

var _dm = ds_map_create();

dl_qualified_locations = ds_list_create();
dl_qualified_locations_old = ds_list_create(); // 
dl_qualified_locations_new = ds_list_create(); // 

dl_loc_cats = ds_list_create(); // Location Categories
dl_loc_num_options = ds_list_create(); // 

dl_prog1 = ds_list_create();
dl_prog2 = ds_list_create();


dm_spell_quest = ds_map_create();
//dm_spell_quest[?STR_Spell+STR_Scene+STR_Name+STR_Rauru] = 


FallingKey_LOC_NUM = val(dm_LOCATIONS[?FallingKey_ITEM_ID+STR_Location+STR_Num], FallingKey_LOC_NUM);
FallingKey_LOC_ID  = val(dm_LOCATIONS[?hex_str(FallingKey_LOC_NUM)+STR_Location+STR_ID], "undefined");
//sdm("FallingKey_LOC_NUM "+hex_str(FallingKey_LOC_NUM)+", FallingKey_RM_NAME: "+FallingKey_RM_NAME+", FallingKey_LOC_ID: "+FallingKey_LOC_ID+", FallingKey_KEY_ID: "+FallingKey_KEY_ID);



// if certain towns have a progression spell, 
// the quest item should be in pool A, 
// otherwise put the item in pool B.
            dl_prog_spells=ds_list_create();
ds_list_add(dl_prog_spells, STR_JUMP,STR_FAIRY,STR_FIRE,STR_REFLECT,STR_ENIGMA,STR_THUNDER);
if (QUEST_NUM==2) ds_list_add(dl_prog_spells, STR_SUMMON);

for(_i=ds_list_size(dl_spell_sequence_spells)-1; _i>=0; _i--)
{
    _spell_name =   dl_spell_sequence_spells[|_i];
    //sdm("seq spell: "+_spell_name);
    if (ds_list_find_index(dl_prog_spells,_spell_name)==-1)
    {   ds_list_add(       dl_prog_spells,_spell_name);  }
}



//sdm("ItemLocations_RANDO_METHOD: "+string(ItemLocations_RANDO_METHOD));



dl_remaining_keys = ds_list_create();
ds_list_copy(dl_remaining_keys,dl_KEYS);
if (KeyLocations_WILL_RANDOMIZE)
{
    ds_list_shuffle(dl_remaining_keys);
}








// ItemPool_A: Progression items
            dl_ItemPool_A = ds_list_create();
ds_list_add(dl_ItemPool_A, STR_CANDLE);
ds_list_add(dl_ItemPool_A, STR_GLOVE);
ds_list_add(dl_ItemPool_A, STR_RAFT);
ds_list_add(dl_ItemPool_A, STR_BOOTS);
ds_list_add(dl_ItemPool_A, STR_FLUTE);
ds_list_add(dl_ItemPool_A, STR_CROSS);
ds_list_add(dl_ItemPool_A, STR_HAMMER);
ds_list_add(dl_ItemPool_A, STR_BRACELET);
ds_list_add(dl_ItemPool_A, STR_BOOK);
ds_list_add(dl_ItemPool_A, STR_RFAIRY); // The Mido fairy gives a reward if you have Rescue Fairy.
//                                                      //
ds_list_add(dl_ItemPool_A, STR_NOTE);

if(!KeyLocations_WILL_RANDOMIZE)
{
    switch(CONTROL_ALLKEY){
    case 0:{                            ds_list_add(dl_ItemPool_A, STR_ALLKEY); break;}
    case 1:{if (_ALLKEY_RANDOM_VALUE<2) ds_list_add(dl_ItemPool_A, STR_ALLKEY); break;}
    }
}


                          _item_id=STR_TROPHY;
dm_spell_quest[?          _item_id+STR_Town+STR_Name] = STR_Ruto;
ds_list_add(dl_ItemPool_A,_item_id);
//                                                                  //
                          _item_id=STR_MIRROR;
dm_spell_quest[?          _item_id+STR_Town+STR_Name] = STR_Saria;
ds_list_add(dl_ItemPool_A,_item_id);
//                                                                  //
                          _item_id=STR_FLOWER;
dm_spell_quest[?          _item_id+STR_Town+STR_Name] = STR_Mido;
ds_list_add(dl_ItemPool_A,_item_id);
//                                                                  //
                          _item_id=STR_CHILD;
dm_spell_quest[?          _item_id+STR_Town+STR_Name] = STR_Darunia;
ds_list_add(dl_ItemPool_A,_item_id);
//                                                                  //
if (QUEST_NUM==2)
{                             _item_id=STR_MASK;
    dm_spell_quest[?          _item_id+STR_Town+STR_Name] = STR_Bulblin;
    ds_list_add(dl_ItemPool_A,_item_id);
}
//                                                                  //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
            dl_ItemPool_B = ds_list_create();
ds_list_add(dl_ItemPool_B, STR_MEAT);
ds_list_add(dl_ItemPool_B, STR_SHIELD);
ds_list_add(dl_ItemPool_B, STR_RING);
ds_list_add(dl_ItemPool_B, STR_PENDANT);
ds_list_add(dl_ItemPool_B, STR_SWORD);
ds_list_add(dl_ItemPool_B, STR_MAP1);
ds_list_add(dl_ItemPool_B, STR_MAP2);
if (QUEST_NUM==2 && INCLUDE_BOTTLE_LOCATION) ds_list_add(dl_ItemPool_B, STR_BOTTLE);
                                           _a=$01;
ds_list_add(dl_ItemPool_B, STR_1UP+hex_str(_a++));
ds_list_add(dl_ItemPool_B, STR_1UP+hex_str(_a++));
ds_list_add(dl_ItemPool_B, STR_1UP+hex_str(_a++));
if (QUEST_NUM==1) ds_list_add(dl_ItemPool_B, STR_1UP+hex_str(_a++));
//sdm("ds_list_size(dl_ItemPool_B): $"+hex_str(ds_list_size(dl_ItemPool_B)));
//                                                      //
//                                                      //
for(_i=f.CONT_MIN_HP+1; _i<=f.CONT_MAX_HP; _i++)
{
    for(_j=1; _j<=f.CONT_PIECE_PER_HP; _j++)
    {
        ds_list_add(dl_ItemPool_B, STR_HEART+hex_str(_i)+hex_str(_j));
    }
}
//sdm("ds_list_size(dl_ItemPool_B): $"+hex_str(ds_list_size(dl_ItemPool_B)));
//                                                      //
for(_i=f.CONT_MIN_MP+1; _i<=f.CONT_MAX_MP; _i++)
{
    for(_j=1; _j<=f.CONT_PIECE_PER_MP; _j++)
    {
        ds_list_add(dl_ItemPool_B, STR_MAGIC+hex_str(_i)+hex_str(_j));
    }
}
//sdm("ds_list_size(dl_ItemPool_B): $"+hex_str(ds_list_size(dl_ItemPool_B)));
//                                                      //
//                                                      //
if (ItemLocations_INCLUDE_PBAG)
{
                 _count = ds_list_size(dl_PBAGS);
    for(_i=0; _i<_count; _i++) ds_list_add(dl_ItemPool_B,dl_PBAGS[|_i]);
}
//sdm("ds_list_size(dl_ItemPool_B): $"+hex_str(ds_list_size(dl_ItemPool_B)));










// -----------------------------------------------------------
                dl_ItemPool_C = ds_list_create();
ds_list_copy(   dl_ItemPool_C, dl_ItemPool_B);
ds_list_shuffle(dl_ItemPool_C);


ds_list_copy(   dl_prog1, dl_ItemPool_A);
ds_list_shuffle(dl_prog1);





if (CONTROL_ALLKEY==1 
&& !KeyLocations_WILL_RANDOMIZE 
&&  ds_list_find_index(dl_ItemPool_A,STR_ALLKEY)==-1 )
{
    if (_ALLKEY_RANDOM_VALUE<8)
    {
        ds_list_add(dl_ItemPool_A,STR_ALLKEY);
        
        _count  = ds_list_size(dl_prog1);
        _count1 = _count div 3;
        _idx    = _count-2;
        _idx   -= _count1;
        _idx=irandom_range(_idx, _idx+_count1);
        ds_list_insert(dl_prog1, _idx, STR_ALLKEY);
    }
}
//if (DEBUG){debug_str="Item pools set."; sdm(debug_str); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)]=debug_str;}














// -----------------------------------------------------------
// A location that doesn't require anything else to obtain the item at it once in its room
SafeLocation_LOC_NUM = -1;
/* // *** I don't think this is actually necessary..
if (ds_list_size(    dl_SAFE_LOCATION_NUMS)){
    ds_list_shuffle( dl_SAFE_LOCATION_NUMS);
SafeLocation_LOC_NUM=dl_SAFE_LOCATION_NUMS[|0];
}*/



// -----------------------------------------------------------
ds_list_clear(dl_locations_remaining);

for(_i=ds_list_size(dl_item_location_NUMS)-1; _i>=0; _i--)
{
        _loc_num =  dl_item_location_NUMS[|_i];
    if (_loc_num!=SafeLocation_LOC_NUM)
    {
        if(!KeyLocations_WILL_RANDOMIZE 
        ||  _loc_num != val(dm_LOCATIONS[?STR_ALLKEY+STR_Location+STR_Num]) )
        {
            ds_list_add(dl_locations_remaining, _loc_num);
        }
    }
}

if (ItemLocations_INCLUDE_PBAG)
{
    for(_i=ds_list_size(dl_pbag_location_NUMS)-1; _i>=0; _i--)
    {
            _loc_num =  dl_pbag_location_NUMS[|_i];
        if (_loc_num!=SafeLocation_LOC_NUM)
        {   ds_list_add(dl_locations_remaining, _loc_num);  }
    }
}

if (KeyLocations_WILL_RANDOMIZE)
{
    for(_i=ds_list_size(dl_key_location_NUMS)-1; _i>=0; _i--)
    {
            _loc_num =  dl_key_location_NUMS[|_i];
        if (_loc_num!=  FallingKey_LOC_NUM 
        &&  _loc_num!=SafeLocation_LOC_NUM )
        {   ds_list_add(dl_locations_remaining, _loc_num);  }
    }
}


ds_list_shuffle(dl_locations_remaining);

//if (DEBUG){debug_str="dl_locations_remaining set."; sdm(debug_str); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)]=debug_str;}







// -----------------------------------------------------------
if (DEBUG){
debug_str  =      "Remaining Locations"+" COUNT $"+hex_str(ds_list_size(dl_locations_remaining));
debug_str += ", "+"Remaining Items"    +" COUNT $"+hex_str(ds_list_size(dl_prog1)+ds_list_size(dl_ItemPool_C));
debug_str += ", "+"Remaining Keys"     +" COUNT $"+hex_str(ds_list_size(dl_remaining_keys));
repeat(1){sdm(""); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)] = "";}
sdm(debug_str);    dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)] = debug_str;
//repeat(1){sdm(""); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)] = "";}
}




// -----------------------------------------------------------
if(!ds_list_size(dl_locations_remaining))
{
    exit; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

if(0){
_count=ds_list_size(dl_prog1);
for(_i=0; _i<_count; _i++) sdm("dl_prog1[|$"+hex_str(_i)+"] = "+dl_prog1[|_i]);
sdm("");
}






Rando_randomize_items_1();
//if (isVal(ItemLocations_RANDO_METHOD,1,2)) Rando_randomize_items_1();
//else                                       Rando_randomize_items_2();








// Scene outside of Fire-Vines Cave
dm_save_data[?Area_WestA+"40"+STR_file_name+STR_Quest+hex_str(QUEST_NUM)] = "WestA_"+"002";



























// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
if (ItemLocations_NPC_GIVE_HINTS 
||  ItemLocations_ZELDA_HINT )
{
    var _area,_area1;
    var _dialogue=undefined;
    var _pos;
    var _dk_loc, _dk_spawn;
    var _dm_set_area_counts=ds_map_create();
    var _dl_set=ds_list_create();
    var _dl_choices=ds_list_create();
    var _dl_area_choices=ds_list_create();
    var _dm_hint_location_requirements=ds_map_create();
    
    
    
    
    // ------------------------------------------------------------------------------
    // ------------------------------------------------------------------------------
    if (ItemLocations_NPC_GIVE_HINTS)
    {
        random_set_seed(Rando_SEED);
        
        var _dl_item_loc_nums=ds_list_create();
        var _dl_HINT_NUMS=ds_list_create();
        var _dl_BOSS_NAMES=ds_list_create();
        ds_list_add(_dl_BOSS_NAMES,"HORSEHEAD","HELMETHEAD","REBONACK","CAROCK","GOOMA","BARBA");
        
        
        ds_list_copy(_dl_item_loc_nums,dl_locnum_that_gave_prog);
        if (1)
        {
            var _dl_ITEM_IDS=ds_list_create();
            ds_list_add(_dl_ITEM_IDS,STR_MEAT,STR_SHIELD,STR_RING,STR_PENDANT,STR_SWORD);
            _count=ds_list_size(_dl_ITEM_IDS);
            for(_i=0; _i<_count; _i++)
            {
                _item_id  = _dl_ITEM_IDS[|_i];
                _loc_num  = val(dm_save_data[?_item_id+STR_Location+STR_Num+STR_Randomized]);
                if (_loc_num 
                &&  ds_list_find_index(_dl_item_loc_nums,_loc_num)==-1 )
                {   ds_list_add(       _dl_item_loc_nums,_loc_num);  }
            }
            
            ds_list_destroy(_dl_ITEM_IDS); _dl_ITEM_IDS=undefined;
        }
        
        
        
        ds_list_clear(_dl_HINT_NUMS);
        _count1=val(g.dm_RandoHints[?STR_Hint+STR_Count]);
        for(_i=1; _i<=_count1; _i++) ds_list_add(_dl_HINT_NUMS,_i);
        ds_list_shuffle(_dl_HINT_NUMS);
        
        _count=ds_list_size(_dl_item_loc_nums);
        for(_i=0; _i<_count; _i++)
        {
            _loc_num  = _dl_item_loc_nums[|_i];
            _dk_loc   = STR_Location+hex_str(_loc_num);
            _item_id  = dm_save_data[?_dk_loc+STR_Item+STR_ID+STR_Randomized];
            _dk_spawn = dm_save_data[?_dk_loc+STR_Spawn+STR_Datakey];
            
            if (ItemLocations_ZELDA_HINT==1 
            &&  _item_id==STR_ALLKEY )
            {
                continue;//_i
            }
            
            ds_list_clear(_dl_choices);
            _j=1;
            while (true)
            //for(_j=1; _j<=$20; _j++)
            {   // different kinds of hints for an item location
                _val = dm_LOCATIONS[?hex_str(_loc_num)+STR_Hint+hex_str(_j++)];
                if (is_undefined(_val)) break;//_j
                ds_list_add(_dl_choices,_val);
            }
            
            if (ds_list_size(_dl_choices))
            {
                ds_list_shuffle(_dl_choices);
                _dialogue = _dl_choices[|0];
                
                if (DungeonBoss_WILL_RANDOMIZE 
                &&  ds_list_size(_dl_choices)>1 
                &&  area_is_dungeon(string_copy(_dk_spawn,1,AreaID_LEN)) )
                {
                    for(_j=ds_list_size(_dl_BOSS_NAMES)-1; _j>=0; _j--)
                    {
                        _val = _dl_BOSS_NAMES[|_j];
                        _pos = string_pos(_val,_dialogue);
                        if (_pos)
                        {
                            _dialogue = _dl_choices[|1];
                            break;//_j
                        }
                    }
                }
                
                _pos=string_pos("&",_dialogue);
                if (_pos)
                {
                    _val = string_upper(string_letters(_item_id));
                    _dialogue = string_delete(_dialogue,_pos,1);
                    _dialogue = string_insert(_val,_dialogue,_pos);
                    //_dialogue = string_replace(_dialogue,_val,_pos);
                }
                
                
                ds_list_clear(_dl_area_choices);
                for(_j=1; _j<=_count1; _j++) // each hint location
                {
                    _qual=false;
                    _area=g.dm_RandoHints[?hex_str(_j)+STR_Area];
                    if(!is_undefined(_area) 
                    &&  ds_list_find_index(_dl_set,_j)==-1 
                    &&  ds_list_find_index(_dl_area_choices,_area)==-1 )
                    {
                        if (0) // make sure hint location isnt locked behind its item
                        {
                            _rm_name=val(g.dm_RandoHints[?hex_str(_j)+STR_Rm+STR_Name]);
                            switch(_rm_name)
                            {
                                case "_WestA_24":{ // 'THIS IS<KINGS TOMB'
                                //_qual = !isVal(_item_id);
                                break;}
                            }
                        }
                        else
                        {
                            _qual=true;
                        }
                        
                        if (_qual) ds_list_add(_dl_area_choices,_area);
                    }
                }
                
                if (ds_list_size(_dl_area_choices))
                {
                    ds_list_shuffle(_dl_area_choices);
                    
                    _area=0;
                    if (1) // limit each area to 3 hints to prevent clumping
                    {
                        for(_j=ds_list_size(_dl_area_choices)-1; _j>=0; _j--)
                        {
                            _area1=_dl_area_choices[|_j];
                            if (_area1==STR_Other 
                            ||  val(_dm_set_area_counts[?_area1])<3 )
                            {
                                _area=_area1;
                                break;//_j
                            }
                        }
                    }
                    
                    if (_area==0) _area=_dl_area_choices[|0];
                    
                    
                    for(_j=0; _j<_count1; _j++)
                    {
                        _num=_dl_HINT_NUMS[|_j];
                        _area1=g.dm_RandoHints[?hex_str(_num)+STR_Area];
                        _val  =g.dm_RandoHints[?hex_str(_num)+STR_Dialogue+STR_Datakey];
                        
                        if (ds_list_find_index(_dl_set,_num)==-1 
                        && !is_undefined(_area1) 
                        &&  _area==_area1 )
                        {
                            if(!is_undefined(_val)) // dialogue datakey
                            {
                                _count3=val(dm_save_data[?STR_Rando+STR_Hint+STR_Count])+1;
                                dm_save_data[?STR_Rando+STR_Hint+STR_Count]=_count3;
                                
                                dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Dialogue+STR_Datakey]=_val;
                                dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Dialogue]=_dialogue;
                                dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Item]=_item_id;
                                dm_save_data[?STR_Rando+STR_Hint+_val+STR_Hint+STR_Num]=_count3;
                                dm_save_data[?STR_Rando+STR_Hint+_val]=_dialogue;
                                
                                ds_list_add(_dl_set,_num);
                                _dm_set_area_counts[?_area] = val(_dm_set_area_counts[?_area])+1;
                                
                                debug_str  = _item_id+string_repeat(" ",string_length(STR_BRACELET)-string_length(_item_id));
                                debug_str += " hint dialogue '"+_dialogue+"' set to datakey "+_val;
                                sdm(debug_str); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)] = debug_str;
                                break;//_j
                            }
                        }
                    }
                }
            }
        }
        
        
        ds_list_destroy(_dl_item_loc_nums); _dl_item_loc_nums=undefined;
        ds_list_destroy(_dl_HINT_NUMS); _dl_HINT_NUMS=undefined;
        ds_list_destroy(_dl_BOSS_NAMES); _dl_BOSS_NAMES=undefined;
    }
    
    
    
    
    
    
    
    
    // ------------------------------------------------------------------------------
    // ------------------------------------------------------------------------------
    if (ItemLocations_ZELDA_HINT)
    {
        random_set_seed(Rando_SEED);
        
        _dialogue = undefined;
        
        
        
        
        if (ItemLocations_ZELDA_HINT==1)
        {
            _item_id = STR_ALLKEY;
            
            if (ALLKEY_LOC_NUM)
            {
                ds_list_clear(_dl_choices);
                for(_j=1; _j<=$20; _j++)
                {   // different kinds of hints for an item location
                    _val = dm_LOCATIONS[?hex_str(ALLKEY_LOC_NUM)+STR_Hint+hex_str(_j)];
                    if (is_undefined(_val)) break;//_j
                    ds_list_add(_dl_choices,_val);
                }
                
                if (ds_list_size(   _dl_choices))
                {
                    ds_list_shuffle(_dl_choices);
                    _dialogue =     _dl_choices[|0];
                    _pos=string_pos("&",_dialogue);
                    if (_pos)
                    {
                        _val = string_upper(string_letters(_item_id));
                        _dialogue = string_delete(_dialogue,_pos,1);
                        _dialogue = string_insert(_val,_dialogue,_pos);
                    }
                }
            }
        }
        
        
        
        
        if (ItemLocations_ZELDA_HINT==2)
        {
            _item_id = STR_JUMP;
            //sdm("");sdm("STR_JUMP+STR_Location: "+string(val(dm_save_data[?STR_JUMP+STR_Location])));sdm("");
            switch(val(dm_save_data[?STR_JUMP+STR_Location]))
            {
                case STR_Rauru:{
                _dialogue=choose("THE JUMP<SPELL IS<IN RAURU.", 
                                 "JUMP SPELL<IS IN A<FOREST<TOWN.", 
                                 "JUMP SPELL<IS IN A<NEARBY<TOWN.");
                break;}
                
                case STR_Ruto:{
                _dialogue=choose("THE JUMP<SPELL IS<IN RUTO.", 
                                 "JUMP SPELL<IS IN A<MOUNTAIN<TOWN.", 
                                 "YOU NEED<THE TROPHY<FOR THE<JUMP SPELL", 
                                 "JUMP SPELL<IS IN A<NEARBY<TOWN.");
                break;}
                
                case STR_Saria:{
                _dialogue=choose("THE JUMP<SPELL IS<IN SARIA.", 
                                 "JUMP SPELL<IS IN A<WATER TOWN", 
                                 "JUMP SPELL<IS IN A<CURSED<TOWN.", 
                                 "YOU NEED<THE MIRROR<FOR THE<JUMP SPELL");
                break;}
                
                case STR_Mido:{
                _dialogue=choose("THE JUMP<SPELL IS<IN MIDO.", 
                                 "JUMP SPELL<IS IN A<WATER TOWN", 
                                 "YOU NEED<THE FLOWER<FOR THE<JUMP SPELL");
                break;}
                
                case STR_Darunia:{
                _dialogue=choose("THE JUMP<SPELL IS<IN DARUNIA", 
                                 "JUMP SPELL<IS IN A<MOUNTAIN<TOWN.", 
                                 "JUMP SPELL<IS IN A<CURSED<TOWN.", 
                                 "YOU NEED<THE CHILD<FOR THE<JUMP SPELL");
                break;}
                
                case STR_New_Kasuto:{
                _dialogue=choose("THE JUMP<SPELL IS<IN<NEW KASUTO", 
                                 "JUMP SPELL<IS IN A<KASUTO<TOWN.", 
                                 "YOU NEED<THE HAMMER<FOR THE<JUMP SPELL");
                break;}
                
                case STR_Old_Kasuto:{
                _dialogue=choose("THE JUMP<SPELL IS<IN<OLD KASUTO", 
                                 "JUMP SPELL<IS IN A<KASUTO<TOWN.", 
                                 "YOU NEED<THE CROSS<FOR THE<JUMP SPELL");
                break;}
            }
        }
        
        
        if(!is_undefined(_dialogue))
        {
            _count3=val(dm_save_data[?STR_Rando+STR_Hint+STR_Count])+1;
            dm_save_data[?STR_Rando+STR_Hint+STR_Count]=_count3;
            
            var _DIALOGUE_DK = STR_Zelda+STR_Hint;
            dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Dialogue+STR_Datakey]=_DIALOGUE_DK;
            dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Dialogue]=_dialogue;
            dm_save_data[?STR_Rando+STR_Hint+hex_str(_count3)+STR_Item]=_item_id;
            dm_save_data[?STR_Rando+STR_Hint+_DIALOGUE_DK+STR_Hint+STR_Num]=_count3;
            dm_save_data[?STR_Rando+STR_Hint+_DIALOGUE_DK]=_dialogue;
            
            dm_save_data[?STR_Zelda+STR_Hint+STR_Dialogue]=_dialogue;
        }
    }
    
    
    
    
    ds_map_destroy(_dm_set_area_counts); _dm_set_area_counts=undefined;
    ds_map_destroy(_dm_hint_location_requirements); _dm_hint_location_requirements=undefined;
    
    ds_list_destroy(_dl_set); _dl_set=undefined;
    ds_list_destroy(_dl_choices); _dl_choices=undefined;
    ds_list_destroy(_dl_area_choices); _dl_area_choices=undefined;
}

ds_list_destroy(dl_locnum_that_gave_prog); dl_locnum_that_gave_prog=undefined;









// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// Randomize MAP sellers prices
random_set_seed(Rando_SEED);

if (DEBUG){sdm(""); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)]="";}

var _pbag_price_min = 0;
var _pbag_price_max = 0;
var _total=0;
var _item_id2 = undefined;
var _version = 1;
var _objver1 = undefined;
var _val1,_val2,_val3;
var _min,_max;
var _datakey = undefined;
var _item_type = undefined;
var _location_num_ = 0;

_count=val(dm_LOCATIONS[?STR_Total+STR_Location+STR_Count]);
for(_i=1; _i<=_count; _i++)
{
    _location_num_ = hex_str(_i);
    _item_type = dm_LOCATIONS[?_location_num_+STR_Item+STR_Type];
    if(!is_undefined(_item_type))
    {
        if (_item_type==STR_MAP1 
        ||  _item_type==STR_MAP2 )
        {
            _item_id = dm_save_data[?STR_Location+_location_num_+STR_Item+STR_ID+STR_Randomized];
            if(!is_undefined(_item_id))
            {
                var                                      _TYPE=1; // keys, progression items, support items, 
                     if (string_pos(STR_PBAG, _item_id)) _TYPE=2;
                else if (string_pos(STR_HEART,_item_id)) _TYPE=3;
                else if (string_pos(STR_MAGIC,_item_id)) _TYPE=3;
                else if (string_pos(STR_1UP,  _item_id)) _TYPE=3;
                
                switch(_TYPE)
                {   // ----------------------------------------------------------------
                    default:{ // _TYPE==1. keys, progression items, support items, 
                    _max = 2000;
                    _min = 300;
                    
                    // So the player doesn't get stuck grinding for xp to get past the first area.
                    if (TownLocations_WILL_RANDOMIZE)
                    {   // TODO: Be more specific and check if the player will need the item to get past the first area.
                        if (val(dm_save_data[?STR_Town+STR_Rando+STR_Rauru+"B"])==STR_Nabooru 
                        ||  val(dm_save_data[?STR_Town+STR_Rando+STR_Rauru+"B"])==STR_New_Kasuto 
                        ||  val(dm_save_data[?STR_Town+STR_Rando+STR_Ruto +"B"])==STR_Nabooru 
                        ||  val(dm_save_data[?STR_Town+STR_Rando+STR_Ruto +"B"])==STR_New_Kasuto )
                        {
                            if (string_pos(STR_KEY,_item_id) 
                            ||  ds_list_find_index(dl_ItemPool_A,_item_id)!=-1 )
                            {
                                _max = 800;
                            }
                        }
                    }
                    break;}
                    
                    
                    
                    // ----------------------------------------------------------------
                    case 2:{ // PBags
                    if(!_pbag_price_max)
                    {
                        _count2=0;
                        
                                     _count1 = ds_list_size(dl_PBAGS);
                        for(_j=0; _j<_count1; _j++)
                        {
                            _item_id2 = string(dl_PBAGS[|_j]);
                            _version  = val(g.dm_spawn[?_item_id2+STR_Version]);
                            _objver1  = object_get_name(ItmE0) + hex_str(_version);
                            _idx = val(g.dm_go_prop[?_objver1+STR_XP], -1);
                            if (_idx+1)
                            {
                                _val2 = g.dl_XP[|_idx];
                                if (XP_WILL_RANDOMIZE) _val2 = val(dm_save_data[?STR_XP+hex_str(_idx)], _val2);
                                if (_val2)
                                {
                                    _total += _val2;
                                    _count2++;
                                }
                            }
                        }
                        
                        if (_total 
                        &&  _total>=_count2 )
                        {
                            _val3 = round(_total/_count2);
                            if (_val3)
                            {
                                _val2 = 100;
                                _val3 = max(_val2+50, _val3);
                                _pbag_price_max = _val3+_val2;
                                _pbag_price_min = _val3-_val2;
                            }
                        }
                    }
                    
                    
                    if (_pbag_price_max)
                    {
                        _max = _pbag_price_max;
                        _min = _pbag_price_min;
                    }
                    else
                    {
                        _max = 550;
                        _min = 350;
                    }
                    break;}
                    
                    
                    
                    // ----------------------------------------------------------------
                    case 3:{ // Container Pieces, 1UP, 
                    _max = 4000;
                    _min = 300;
                    break;}
                }
                
                
                
                
                _min = max(1,_min);
                _max = max(_min+100,_max);
                _val = irandom(_max-_min) + _min;
                _val = clamp(_val, _min,_max);
                
                _datakey = STR_Map+string(1+(_item_type==STR_MAP2));
                dm_save_data[?_datakey+STR_Cost] = _val;
                
                if (DEBUG){debug_str = _datakey+", _min: "+string(_min)+", _max: "+string(_max)+", _val: "+string(_val)+", _item_id: "+_item_id+", _TYPE: "+string(_TYPE);
                sdm(debug_str); dm_debug_data[?STR_Data+'01'+hex_str(++debug_data_count)] = debug_str;
                }
            }
        }
    }
}




















// ==============================================================================
ds_map_destroy(_dm); _dm=undefined;

ds_list_destroy(dl_remaining_keys); dl_remaining_keys=undefined;
ds_list_destroy(dl_qualified_locations); dl_qualified_locations=undefined;
ds_list_destroy(dl_qualified_locations_old); dl_qualified_locations_old=undefined;
ds_list_destroy(dl_qualified_locations_new); dl_qualified_locations_new=undefined;

ds_list_destroy(dl_prog1); dl_prog1=undefined;
ds_list_destroy(dl_prog2); dl_prog2=undefined;

ds_list_destroy(dl_prog_spells); dl_prog_spells=undefined;
ds_map_destroy(dm_spell_quest); dm_spell_quest=undefined;

ds_list_destroy(dl_loc_cats); dl_loc_cats=undefined;
ds_list_destroy(dl_loc_num_options); dl_loc_num_options=undefined;





