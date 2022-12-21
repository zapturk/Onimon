function monsters_enum(){
//Monsters enumerator. This is what you will type when assigning monsters to trainers.
//By default we have Dokimon's monster names here, but you will likely want to change these
//to match your own games monster list. 

//Enumerators are important for not making mistakes and causing crashes when assigning monsters.
//When assigning a trainers monsters in their team, after typing "m.", you will see a pop-up of
//all the names in this list, so you can click one, or finish typing it. As long as you type one
//of the monsters in this list below, the game should never crash in regards to this.

//NOTICE !!
//This list must be in the same order as your "spr_monsters" sprites, so if you re-orgnaize monsters
//in any of your monster sprites, you will also have to edit this to match. This is also true for
//the order at which monsters are drawn in the visual editor. Please be careful!

enum m{
	FURREAL, LEEKLOO, LEEKSWORD, NEKOSWORD, NEKOSWORD2, CARROTTI, KAKARATT, QUACKFIL, QUACKFEAR,
	CASPER, SHADE, NIMBIS, LLOUDIOUS, CRESYL, CRESSENTIA, FLOUNDER, MUDSLIP, BUNDUST,
	JUSKITTEN, HARLEQUITTEN, NYAROLET, MOISEN, BIRZHEN, LUCIFEATHER, FLYEURNIX, HOOTLET, ZAPBORA, 
	FIREKITTY, FIRESTAND, EMPTY1, HARACKER, HAREATE, SOUL, JISTERY, LOOMLEAK, MARILLO,
	LUNA, ECLIPSE, WILLOW, GASTRIFIL, KINDLE, COALBRA, EMBOA, BABY_LLAMA, ELECTLLAMA,
	LYNX, EMBEROX, GLACEIA, FLUROX, BOLTREX, YOROX, FOX1, FOX2, CORSAC,
	MARU, TOKKEN, KATSU,  SKORPO, SCORP2, SS_SCORP, EMPTY2, EMPTY3, EMPTY4,
	EMPTY5, EMPTY6, EMPTY7, EMPTY8, EMPTY9, EMPTY10, EMPTY11, EMPTY12, EMPTY13, 
	EMPTY14, EMPTY15, EMPTY16, EMPTY17, EMPTY18, EMPTY19, EMPTY20, EMPTY21, EMPTY22, 
	EMPTY23, EMPTY24, EMPTY25, EMPTY26, EMPTY27, EMPTY28, AOMON, AOIMON, DARKMON,
	KNYFAGON, KYLEMAN, TKOB, TKOBOM, XKOBOMA, DARTARGET, EMPTY29, EMPTY30,
	}
}