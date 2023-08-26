//
//  SpeedSettingsHour.swift
//  Transmission
//
//  Created by Federico Arvat on 25/08/23.
//

import Foundation

public enum SpeedSettingsHour: Int, CaseIterable {
	case hour0000 = 0
	case hour0015 = 15
	case hour0030 = 30
	case hour0045 = 45
	case hour0100 = 60
	case hour0115 = 75
	case hour0130 = 90
	case hour0145 = 105
	case hour0200 = 120
	case hour0215 = 135
	case hour0230 = 150
	case hour0245 = 165
	case hour0300 = 180
	case hour0315 = 195
	case hour0330 = 210
	case hour0345 = 225
	case hour0400 = 240
	case hour0415 = 255
	case hour0430 = 270
	case hour0445 = 285
	case hour0500 = 300
	case hour0515 = 315
	case hour0530 = 330
	case hour0545 = 345
	case hour0600 = 360
	case hour0615 = 375
	case hour0630 = 390
	case hour0645 = 405
	case hour0700 = 420
	case hour0715 = 435
	case hour0730 = 450
	case hour0745 = 465
	case hour0800 = 480
	case hour0815 = 495
	case hour0830 = 510
	case hour0845 = 525
	case hour0900 = 540
	case hour0915 = 555
	case hour0930 = 570
	case hour0945 = 585
	case hour1000 = 600
	case hour1015 = 615
	case hour1030 = 630
	case hour1045 = 645
	case hour1100 = 660
	case hour1115 = 675
	case hour1130 = 690
	case hour1145 = 705
	case hour1200 = 720
	case hour1215 = 735
	case hour1230 = 750
	case hour1245 = 765
	case hour1300 = 780
	case hour1315 = 795
	case hour1330 = 810
	case hour1345 = 825
	case hour1400 = 840
	case hour1415 = 855
	case hour1430 = 870
	case hour1445 = 885
	case hour1500 = 900
	case hour1515 = 915
	case hour1530 = 930
	case hour1545 = 945
	case hour1600 = 960
	case hour1615 = 975
	case hour1630 = 990
	case hour1645 = 1005
	case hour1700 = 1020
	case hour1715 = 1035
	case hour1730 = 1050
	case hour1745 = 1065
	case hour1800 = 1080
	case hour1815 = 1095
	case hour1830 = 1110
	case hour1845 = 1125
	case hour1900 = 1140
	case hour1915 = 1155
	case hour1930 = 1170
	case hour1945 = 1185
	case hour2000 = 1200
	case hour2015 = 1215
	case hour2030 = 1230
	case hour2045 = 1245
	case hour2100 = 1260
	case hour2115 = 1275
	case hour2130 = 1290
	case hour2145 = 1305
	case hour2200 = 1320
	case hour2215 = 1335
	case hour2230 = 1350
	case hour2245 = 1365
	case hour2300 = 1380
	case hour2315 = 1395
	case hour2330 = 1410
	case hour2345 = 1425
	
	public var description: String {
		switch self {
		case .hour0000:
			return "00:00"
		case .hour0015:
			return "00:15"
		case .hour0030:
			return "00:30"
		case .hour0045:
			return "00:45"
		case .hour0100:
			return "01:00"
		case .hour0115:
			return "01:15"
		case .hour0130:
			return "01:30"
		case .hour0145:
			return "01:45"
		case .hour0200:
			return "02:00"
		case .hour0215:
			return "02:15"
		case .hour0230:
			return "02:30"
		case .hour0245:
			return "02:45"
		case .hour0300:
			return "03:00"
		case .hour0315:
			return "03:15"
		case .hour0330:
			return "03:30"
		case .hour0345:
			return "03:45"
		case .hour0400:
			return "04:00"
		case .hour0415:
			return "04:15"
		case .hour0430:
			return "04:30"
		case .hour0445:
			return "04:45"
		case .hour0500:
			return "05:00"
		case .hour0515:
			return "05:15"
		case .hour0530:
			return "05:30"
		case .hour0545:
			return "05:45"
		case .hour0600:
			return "06:00"
		case .hour0615:
			return "06:15"
		case .hour0630:
			return "06:30"
		case .hour0645:
			return "06:45"
		case .hour0700:
			return "07:00"
		case .hour0715:
			return "07:15"
		case .hour0730:
			return "07:30"
		case .hour0745:
			return "07:45"
		case .hour0800:
			return "08:00"
		case .hour0815:
			return "08:15"
		case .hour0830:
			return "08:30"
		case .hour0845:
			return "08:45"
		case .hour0900:
			return "09:00"
		case .hour0915:
			return "09:15"
		case .hour0930:
			return "09:30"
		case .hour0945:
			return "09:45"
		case .hour1000:
			return "10:00"
		case .hour1015:
			return "10:15"
		case .hour1030:
			return "10:30"
		case .hour1045:
			return "10:45"
		case .hour1100:
			return "11:00"
		case .hour1115:
			return "11:15"
		case .hour1130:
			return "11:30"
		case .hour1145:
			return "11:45"
		case .hour1200:
			return "12:00"
		case .hour1215:
			return "12:15"
		case .hour1230:
			return "12:30"
		case .hour1245:
			return "12:45"
		case .hour1300:
			return "13:00"
		case .hour1315:
			return "13:15"
		case .hour1330:
			return "13:30"
		case .hour1345:
			return "13:45"
		case .hour1400:
			return "14:00"
		case .hour1415:
			return "14:15"
		case .hour1430:
			return "14:30"
		case .hour1445:
			return "14:45"
		case .hour1500:
			return "15:00"
		case .hour1515:
			return "15:15"
		case .hour1530:
			return "15:30"
		case .hour1545:
			return "15:45"
		case .hour1600:
			return "16:00"
		case .hour1615:
			return "16:15"
		case .hour1630:
			return "16:30"
		case .hour1645:
			return "16:45"
		case .hour1700:
			return "17:00"
		case .hour1715:
			return "17:15"
		case .hour1730:
			return "17:30"
		case .hour1745:
			return "17:45"
		case .hour1800:
			return "18:00"
		case .hour1815:
			return "18:15"
		case .hour1830:
			return "18:30"
		case .hour1845:
			return "18:45"
		case .hour1900:
			return "19:00"
		case .hour1915:
			return "19:15"
		case .hour1930:
			return "19:30"
		case .hour1945:
			return "19:45"
		case .hour2000:
			return "20:00"
		case .hour2015:
			return "20:15"
		case .hour2030:
			return "20:30"
		case .hour2045:
			return "20:45"
		case .hour2100:
			return "21:00"
		case .hour2115:
			return "21:15"
		case .hour2130:
			return "21:30"
		case .hour2145:
			return "21:45"
		case .hour2200:
			return "22:00"
		case .hour2215:
			return "22:15"
		case .hour2230:
			return "22:30"
		case .hour2245:
			return "22:45"
		case .hour2300:
			return "23:00"
		case .hour2315:
			return "23:15"
		case .hour2330:
			return "23:30"
		case .hour2345:
			return "23:45"
		}
	}
}
