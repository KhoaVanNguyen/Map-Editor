//
//  GameSet.swift
//  MapEditor
//
//  Created by Khoa on 11/20/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation

let level1 = ["level1_0","level1_1","level1_2","level1_3","level1_4","level1_5","level1_6","level1_7","level1_8","level1_9","level1_10","level1_11","level1_12","level1_13","level1_14","level1_15","level1_16","level1_17","level1_18","level1_19","level1_20","level1_21","level1_22","level1_23","level1_24","level1_25","level1_26","level1_27","level1_28","level1_29","level1_30","level1_31","level1_32","level1_33","level1_34","level1_35","level1_36","level1_37","level1_38","level1_39","level1_40","level1_41","level1_42","level1_43","level1_44","level1_45","level1_46","level1_47","level1_48"]


let level2 = ["level2_0", "level2_1", "level2_2", "level2_3", "level2_4", "level2_5", "level2_6", "level2_7", "level2_8", "level2_9", "level2_10", "level2_11", "level2_12", "level2_13", "level2_14", "level2_15", "level2_16", "level2_17", "level2_18", "level2_19", "level2_20", "level2_21", "level2_22", "level2_23", "level2_24", "level2_25", "level2_26", "level2_27", "level2_28", "level2_29", "level2_30", "level2_31", "level2_32", "level2_33", "level2_34", "level2_35", "level2_36", "level2_37", "level2_38", "level2_39", "level2_40", "level2_41", "level2_42", "level2_43", "level2_44", "level2_45", "level2_46", "level2_47", "level2_48", "level2_49", "level2_50", "level2_51", "level2_52", "level2_53", "level2_54", "level2_55", "level2_56", "level2_57", "level2_58", "level2_59", "level2_60", "level2_61", "level2_62", "level2_63", "level2_64", "level2_65", "level2_66", "level2_67", "level2_68", "level2_69", "level2_70", "level2_71", "level2_72", "level2_73", "level2_74", "level2_75", "level2_76", "level2_77", "level2_78", "level2_79", "level2_80", "level2_81", "level2_82", "level2_83", "level2_84", "level2_85", "level2_86", "level2_87", "level2_88", "level2_89", "level2_90", "level2_91", "level2_92", "level2_93", "level2_94", "level2_95", "level2_96", "level2_97", "level2_98", "level2_99", "level2_100", "level2_101", "level2_102", "level2_103", "level2_104", "level2_105", "level2_106", "level2_107", "level2_108", "level2_109", "level2_110", "level2_111", "level2_112", "level2_113"]


let level3 = [ "level3_0", "level3_1", "level3_2", "level3_3", "level3_4", "level3_5", "level3_6", "level3_7", "level3_8", "level3_9", "level3_10", "level3_11", "level3_12", "level3_13", "level3_14", "level3_15", "level3_16", "level3_17", "level3_18", "level3_19", "level3_20", "level3_21", "level3_22", "level3_23", "level3_24", "level3_25", "level3_26", "level3_27", "level3_28", "level3_29", "level3_30", "level3_31", "level3_32", "level3_33", "level3_34", "level3_35", "level3_36", "level3_37", "level3_38", "level3_39", "level3_40", "level3_41", "level3_42", "level3_43", "level3_44", "level3_45", "level3_46", "level3_47", "level3_48", "level3_49", "level3_50", "level3_51", "level3_52", "level3_53", "level3_54", "level3_55", "level3_56", "level3_57", "level3_58", "level3_59", "level3_60", "level3_61", "level3_62"]

let level4 = ["level4_0", "level4_1", "level4_2", "level4_3", "level4_4", "level4_5", "level4_6", "level4_7", "level4_8", "level4_9", "level4_10", "level4_11", "level4_12", "level4_13", "level4_14", "level4_15", "level4_16", "level4_17", "level4_18", "level4_19", "level4_20", "level4_21", "level4_22", "level4_23", "level4_24", "level4_25", "level4_26", "level4_27", "level4_28", "level4_29", "level4_30", "level4_31", "level4_32", "level4_33", "level4_34", "level4_35", "level4_36", "level4_37", "level4_38", "level4_39", "level4_40", "level4_41", "level4_42", "level4_43", "level4_44", "level4_45", "level4_46", "level4_47", "level4_48", "level4_49", "level4_50", "level4_51", "level4_52", "level4_53", "level4_54", "level4_55", "level4_56", "level4_57", "level4_58"]




let tileSetLevel1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18,19,20,
                     21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
                     40,41,42,43,44,45,46,47,48]



let tileSetLevel2 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113]


let tileSetLevel3 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63]

let tileSetLevel4 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58]


