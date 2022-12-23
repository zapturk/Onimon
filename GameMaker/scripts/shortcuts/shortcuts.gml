
#region Explanation
//These shortcuts can be used to replace main gamemaker functions and
//will provide shortened fucntion names, the ability to use default values,
//and also in some cases prevent the game from crashing as well.
//I use them constantly and they are fully documented in here and even
//provide multiple exampels of how to use each one
#endregion

function paint(){

//Draw a sprite to the screen. Set sprite or image_index to -1
//to draw the objects current sprite/image index.

//Shorten "draw_sprite(sprite_index, image_index, x, y)" to:
//paint(-1, -1, x, y). 


///@arg x
///@arg y
///@arg sprite
///@arg frame
///@arg xscale
///@arg yscale
///@arg color
///@arg rot

//How to use
//paint(sprite)
//paint(x, y, sprite)
//paint(x, y, sprite, frame)
//paint(x, y, sprite, frame, scale)
//paint(x, y, sprite, frame, xscale, yscale, c_black)

//Draw Self();
if argument_count = 0{
	var _spr;
	_spr = sprite_index;
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	draw_sprite(_spr, 0, x, y);
	return;
	}

if argument_count = 1{
	var _spr;
	if is_string(argument[0]) _spr = asset_get_index(argument[0]);
	else _spr = argument[0];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	draw_sprite(_spr, 0, x, y);
	return;
	}
	
if argument_count = 3{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite(_spr, 0, argument[0], argument[1]);
	return;
	}

if argument_count = 4{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite(_spr, argument[3], argument[0], argument[1]);
	return;
	}

if argument_count = 5{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite_ext(_spr, argument[3], argument[0], argument[1], argument[4], argument[4], 0, -1, 1);
	return;
	}

if argument_count = 6{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite_ext(_spr, argument[3], argument[0], argument[1], argument[4], argument[5], 0, -1, 1);
	return;
	}
	
if argument_count = 7{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite_ext(_spr, argument[3], argument[0], argument[1], argument[4], argument[5], 0, argument[6], 1);
	return;
	}

if argument_count = 8{
	var _spr;
	if is_string(argument[2]) _spr = asset_get_index(argument[2]);
	else _spr = argument[2];
	
	if !sprite_exists(_spr){
		show_debug_message("Sprite not found.");	
		return;
		}
	if !is_real(argument[0]) or !is_real(argument[1]){
		show_debug_message("Coordinates must be reals");
		return;
		}
	draw_sprite_ext(_spr, argument[3], argument[0], argument[1], argument[4], argument[5], argument[7], argument[6], 1);
	return;
	}

}



function create(){
	
//instance_create but better, and shorter! Won't crash your game, choose
//layer or depth based on argument[2]. Simply type a real or a layer name (string)
//of if you're going to "Instances" leave argument[2] as ""
	
///@arg0 x
///@arg1 y
///@arg2 depth
///@arg3 object

//Ways to use:
//create(object)
//create(x, y, object) 
//create(x, y, depth, object)

//Defaults are:
//x and y
//"Instances"
//Object must be specified
//Change default below if desired.

//Defaults
var lay = "Instances";

if argument_count = 0{
	show_debug_message("create script requires at least 1 argument.");
	exit;
	}

if argument_count = 1{
	var _id = instance_create_layer(x, y, lay, argument[0]);
	return(_id);
	}
	
if argument_count = 3{
	if !is_real(argument[0]) or !is_real(argument[1]) or !is_real(argument[2]){
		show_debug_message("Incorrect use of create create script");
		exit;
		}
	var _id = instance_create_layer(argument[0], argument[1], lay, argument[2]);
	return(_id);
	}


if is_string(argument[2]){
	if argument[2] = ""{
		var _id = instance_create_layer(argument[0], argument[1], lay, argument[3]);
		return(_id);
		}
	else{
		var _id = instance_create_layer(argument[0], argument[1], argument[2], argument[3]);
		return(_id);
		}
	}
else if is_real(argument[2]){
	var _id = instance_create_depth(argument[0], argument[1], argument[2], argument[3]);
	return(_id);
	}
else{
	show_debug_message("Incorrect use of create create script");
	}
}

function destroy(){
	
//Use this function to destroy an instance of an object.
//An example of when you would want to do this might be
//deleting an item after the player picked it up.

///@arg id

//How to use:
//destroy();			//This will destroy the object that this function is placed in
//destroy(object);		//This will destroy the object that you put within the paranthesis


if argument_count = 0{
	instance_destroy(id);
	return;
	}

if instance_exists(argument[0]){
	instance_destroy(argument[0]);
	}
}

function text(){

//Paint text to the screen (similar to draw_text)
//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Text/draw_text.htm

///@arg x
///@arg y
///@arg string
///@arg width/scale
///@arg width

//Ways to use:
//text("Hello World")						String only
//text(x+5, y-10, "Hello");					String and coordinates
//text(x+5, y-10, "Hello", 2);				String, coordinates, and scale
//text(x+5, y-10, "Hello", 1200);			String, coordinates, and width of string
//text(x+5, y-10, "Hello", 2, 1200);		String, coordinates, scale, and width of string

var xx, yy, sz, str;
xx = x;
yy = y;
sz = 10;
str = argument[0];

if argument_count = 1{
	//Draw the stuff
	draw_text(xx, yy, str);
	}

if argument_count = 3{
	//Draw the stuff
	draw_text(argument[0], argument[1], argument[2]);
	}
	
if argument_count = 4{
	//Draw the stuff
	if argument[3] > 20 //We're probably NOT doing width
		{
		draw_text_ext(argument[0], argument[1], argument[2], sz, argument[3]);
		}
	else{
		draw_text_transformed(argument[0], argument[1], argument[2], argument[3], argument[3], 0);
		}
	}
	
if argument_count = 5
	{
	//Draw the stuff
	draw_text_ext_transformed(argument[0], argument[1], argument[2], sz, argument[4], argument[3], argument[3], 0);
	}

}

function outline(){
	///draw_text_outlined(x, y, outline color, string color, string) 
	///@arg1 x
	///@arg2 y
	///@arg3 outline_color
	///@arg4 string_color
	///@arg5 string
	///@arg6 scale
	///@arg7 sep
	///@arg8 width
	var xx,yy;  
	xx = argument[0];  
	yy = argument[1];  
  
	//Outline
	if argument[2] != -1{
		draw_set_color(argument[2]);  
		draw_text_ext_transformed(xx+1, yy+1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx-1, yy-1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx,   yy+1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx+1,   yy, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx,   yy-1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx-1,   yy, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx-1, yy+1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		draw_text_ext_transformed(xx+1, yy-1, argument[4], argument[6], argument[7], argument[5], argument[5], 0);  
		}
  
	//Text  
	draw_set_color(argument[3]);
	draw_text_ext_transformed(xx, yy, argument[4], argument[6], argument[7], argument[5], argument[5], 0); 


}

function font(){

//UNFINISHED
///@arg font
if argument[0] == -1 return;
draw_set_font(argument[0]);
}

function color(){

//I mean, hell, why not.. We've come this far, right?

///@arg 0, 1, or color

//Allows us to leave blank to just draw white (default)
if argument_count = 0{
	draw_set_color(c_white);
	return;
	}
	
//Type 0 for white, 1 for black, or the color name
switch argument[0]{
	case -1: return;
	case 0: draw_set_color(c_black); break;
	case 1: draw_set_color(c_white); break;
	default: draw_set_color(argument[0]); break;
	}
}

function hex(){

//Allows you to use hex code for colors
///@arg $000000

//How to use:
//color(hex($FFFFFF));
	
return ((argument[0] & $FF) << 16) | (argument[0] & $FF00) | ((argument[0] >> 16) & $FF);
}

function alpha(){

//Quick shortcut bc why not
///@arg alpha

if argument_count == 1 draw_set_alpha(argument[0]);
else draw_set_alpha(1); //Reset alpha if blank

}

function halign(){

///@desc Shortcut for draw_set_halign();
///@arg0 left/center/right/0/1/2

//Ways to use:
//halign();
//halign(1);
//halign(fa_center);


//Default alignment settings
if argument_count = 0{
	draw_set_halign(fa_center);
	return;
	}

switch argument[0]{
	case fa_left:		draw_set_halign(fa_left); break;
	case fa_center:		draw_set_halign(fa_center); break;
	case fa_right:		draw_set_halign(fa_right); break;
	default: return;	
	}
}

function valign(){
///@desc Shortcut for draw_set_valign();
///@arg0 top/center/bottom/0/1/2

//Ways to use:
//valign();
//valign(1);
//valign(fa_bottom);


//Default alignment settings
if argument_count = 0{
	draw_set_valign(fa_top);
	return;
	}

switch argument[0]{
	case fa_top:		draw_set_valign(fa_top); break;
	case fa_center:		draw_set_valign(fa_center); break;
	case fa_bottom:		draw_set_valign(fa_bottom); break;
	default: return;
	}
	
}

function format(){
///@arg color
///@arg alpha
///@arg font
///@arg halign
///@arg valign
switch argument_count{
	case 1:
		color(argument[0]);
		break;
	case 2:
		if argument[0] != -1 color(argument[0]);
		alpha(argument[1]);
		break;
	case 3:
		if argument[0] != -1 color(argument[0]);
		if argument[1] != -1 alpha(argument[1]);
		font(argument[2]);
		break;
	case 4:
		if argument[0] != -1 color(argument[0]);
		if argument[1] != -1 alpha(argument[1]);
		if argument[2] != -1 font(argument[2]);
		halign(argument[3]);
		break;
	case 5:
		if argument[0] != -1 color(argument[0]);
		if argument[1] != -1 alpha(argument[1]);
		if argument[2] != -1 font(argument[2]);
		if argument[3] != -1 halign(argument[3]);
		valign(argument[4]);
		break;
	default:
		show_debug_message("Incorrect number of arguments for script: format");
		return;
	}
}

function range(){
//Returns a random number between the two numbers you place in the script
///@arg min
///@arg max

if argument_count == 0{
	show_message("Script \"range\" was not given arguments.\n Use it like this: range(3, 7);");
	return irandom_range(5, 10);
	}
return irandom_range(argument[0], argument[1]);
}

function fill_screen(){
///@desc Fill the entire screen with a color
///@arg alpha
///@arg color

//How to use:
//fill_screen();
//fill_screen(alpha);
//fill_screen(alpha, color);

if argument_count == 1 alpha(argument[0]);
if argument_count == 2{
	alpha(argument[0]);
	color(argument[1]);
	}

draw_rectangle(x-1000, y-1000, x+1000, y+1000, 0);

//Reset color and alpha to default (white, 1);
color();
alpha();

}

function paint_healthbar(){

///@arg x
///@arg y
///@arg sprite
///@arg percentage/decimal

//Get current health percentage as a decimal and multiplay it by the sprites width
var width = round(sprite_get_width(argument[2]) * argument[3]);

draw_sprite_part(argument[2], 0, 0, 0, width, sprite_get_height(argument[2]), argument[0], argument[1]);
	
}

#region Less Commonly Used shortcuts
function play(){

///@arg sound
///@arg looping

if argument_count = 1 audio_play_sound(argument[0], 1, 0);
else audio_play_sound(argument[0], 1, argument[1]);
}
	
function sfx(){

//Play sound effects with a random altered pitch

///@arg sound
///@arg pitch +-

//Allows you to only type the sound and use the
//default pitch += of 0.3. Type 0 if not desired.

if argument_count = 0{
	show_debug_message("sfx requires at least 1 argument");
	return 0;
	}

var p, _v, _vv;
if argument_count = 1 p = 0.3;
else p = argument[1];

_v = 1-p;
_vv = 1+p;
if audio_exists(argument[0]){
	var pch = random_range(_v, _vv);
	var snd = argument[0];
	audio_sound_pitch(snd, pch);
	audio_play_sound(snd, 1, 0);
	}
else show_debug_message("Sound does not exist.");

}
	
function sprite(){

//Shortcut~~
///@arg sprite_index

if sprite_index != argument[0]{
	sprite_index = argument[0];
	image_index = 0;
	return 1;
	}
return 0;
}
	
function frame_last(){
	
//Animation End shortcut
	
if (image_index > image_number-1) return 1;
return 0;
}
	
function pick(){

//Choose from a defined list with multiple entries
///@arg arg1
///@arg amount
///@arg arg2
///@arg amount2
//etc

//How to use:
//pick(asobi, 1, mizusan, 1, kusaro, 1, flappy, 4, sizzle, 3);

if argument_count / 2 != round(argument_count / 2) exit;

randomize();
var _pick = ds_list_create();
var o = 0, times = argument_count / 2;
for (var i = 0; i < times; i++;){
	for (var n = 0; n < argument[o+1]; n++;){
		ds_list_add(_pick, argument[o]);
		}
	o+=2;
	}
ds_list_shuffle(_pick);
return ds_list_find_value(_pick, 1);

}

//Strictly for adding foreign characters into the "code"
function _lans(){

#region Thai Characters
/*
เป็นมนุษย์สุดประเสริฐเลิศคุณค่า
กว่าบรรดาฝูงสัตว์เดรัจฉาน
จงฝ่าฟันพัฒนาวิชาการ
อย่าล้างผลาญฤๅเข่นฆ่าบีฑาใคร
ไม่ถือโทษโกรธแช่งซัดฮึดฮัดด่า
หัดอภัยเหมือนกีฬาอัชฌาสัย
ปฏิบัติประพฤติกฎกำหนดใจ
พูดจาให้จ๊ะ ๆ จ๋า ๆ น่าฟังเอยฯ
*/
#endregion

#region Japanese Characters
/*
 あ ぁ い ぃ う ぅ え ぇ  お ぉ か が き ぎ く ぐ け げ こ ご さ ざ し じ
 す ず せ ぜ そ ぞ た だ ち ぢ つ っ づ て で と ど な に ぬ ね の は ば ぱ
 ひ び ぴ ふ ぶ ぷ へ べ ぺ ほ ぼ ぽ ま み む め も ゃ や ゅ ゆ ょ よ ら り
 る れ ろ ゎ わ ゐ ゑ を ん ゔ ゕ ゖ  ゚ ゛ ゜ ゝ ゞ ゟ ゠ ァ ア ィ イ ゥ ウ
 ェ エ ォ オ カ ガ キ ギ ク グ ケ ゲ コ ゴ サ ザ シ ジ ス ズ セ ゼ ソ ゾ タ ダ
 チ ヂ ッ ツ ヅ テ デ ト ド ナ ニ ヌ ネ ノ ハ バ パ ヒ ビ ピ フ ブ プ ヘ ベ ペ
 ホ ボ ポ マ ミ ム メ モ ャ ヤ ュ ユ ョ ヨ ラ リ ル レ ロ ヮ ワ ヰ ヱ ヲ ン ヴ
 ヵ ヶ ヷ ヸ ヹ ヺ ・ ー ヽ ヾヿ日 一 国 会 人 年 大 十 二 本 中 長 出 三 同 時
 政 事 自 行 社 見 月 分 議 後 前 民 生 連 五 発 間 対 上 部 東 者 党 地 合 市 業
 内 相 方 四 定 今 回 新 場 金 員 九 入 選 立 開 手 米 力 学 問 高 代 明 実 円 関
 決 子 動 京 全 目 表 戦 経 通 外 最 言 氏 現 理 調 体 化 田 当 八 六 約 主 題 下
 首 意 法 不 来 作 性 的 要 用 制 治 度 務 強 気 小 七 成 期 公 持 野 協 取 都 和
 統 以 機 平 総 加 山 思 家 話 世 受 区 領 多 県 続 進 正 安 設 保 改 数 記 院 女
 初 北 午 指 権 心 界 支 第 産 結 百 派 点 教 報 済 書 府 活 原 先 共 得 解 名 交
 資 予 川 向 際 査 勝 面 委 告 軍 文 反 元 重 近 千 考 判 認 画 海 参 売 利 組 知
 案 道 信 策 集 在 件 団 別 物 側 任 引 使 求 所 次 水 半 品 昨 論 計 死 官 増 係
 感 特 情 投 示 変 打 男 基 私 各 始 島 直 両 朝 革 価 式 確 村 提 運 終 挙 果 西
 勢 減 台 広 容 
*/
#endregion

}
	
#endregion