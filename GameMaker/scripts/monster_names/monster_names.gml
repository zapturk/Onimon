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
	//Starters
	STARTER_1, STARTER_2, STARTER_3, STARTER_4, STARTER_5, STARTER_6, STARTER_7, STARTER_8, STARTER_9,
	
	MONSTER_10, MONSTER_11, MONSTER_12, MONSTER_13, MONSTER_14, MONSTER_15, MONSTER_16, MONSTER_17, MONSTER_18,
	MONSTER_19, MONSTER_20, MONSTER_21, MONSTER_22, MONSTER_23, MONSTER_24, MONSTER_25, MONSTER_26, MONSTER_27,
	MONSTER_28, MONSTER_29, MONSTER_30, MONSTER_31, MONSTER_32, MONSTER_33, MONSTER_34, MONSTER_35, MONSTER_36,
	MONSTER_37, MONSTER_38, MONSTER_39, MONSTER_40, MONSTER_41, MONSTER_42, MONSTER_43, MONSTER_44, MONSTER_45,
	MONSTER_46, MONSTER_47, MONSTER_48, MONSTER_49, MONSTER_50, MONSTER_51, MONSTER_52, MONSTER_53, MONSTER_54,
	MONSTER_55, MONSTER_56, MONSTER_57, MONSTER_58, MONSTER_59, MONSTER_60, MONSTER_61, MONSTER_62, MONSTER_63,
	MONSTER_64, MONSTER_65, MONSTER_66, MONSTER_67, MONSTER_68, MONSTER_69, MONSTER_70, MONSTER_71, MONSTER_72,
	MONSTER_73, MONSTER_74, MONSTER_75, MONSTER_76, MONSTER_77, MONSTER_78, MONSTER_79, MONSTER_80, MONSTER_81,
	MONSTER_82, MONSTER_83, MONSTER_84, MONSTER_85, MONSTER_86, MONSTER_87, MONSTER_88, MONSTER_89, MONSTER_90,
	MONSTER_91, MONSTER_92, MONSTER_93, MONSTER_94, MONSTER_95, MONSTER_96, MONSTER_97, MONSTER_98, MONSTER_99,
	
	MONSTER_100, MONSTER_101, MONSTER_102, MONSTER_103, MONSTER_104, MONSTER_105, MONSTER_106, MONSTER_107, MONSTER_108,
	MONSTER_109, MONSTER_110, MONSTER_111, MONSTER_112, MONSTER_113, MONSTER_114, MONSTER_115, MONSTER_116, MONSTER_117,
	MONSTER_118, MONSTER_119, MONSTER_120, MONSTER_121, MONSTER_122, MONSTER_123, MONSTER_124, MONSTER_125, MONSTER_126,
	MONSTER_127, MONSTER_128, MONSTER_129, MONSTER_130, MONSTER_131, MONSTER_132, MONSTER_133, MONSTER_134, MONSTER_135,
	MONSTER_136, MONSTER_137, MONSTER_138, MONSTER_139, MONSTER_140, MONSTER_141, MONSTER_142, MONSTER_143, MONSTER_144
	}
}