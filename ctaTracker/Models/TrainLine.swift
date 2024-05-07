//
//  AllTrainRoutes.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import Foundation

enum TrainLine: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    case green = "g"
    case pink = "pink"
    case purple = "p"
    case purpleExpress = "pexp"
    case orange = "org"
    case yellow = "y"
    case brown = "brn"
}

let lineStopsOrdering = [
    "yellow": [40140, 41680, 40900],
    "brown": [
      41290, 41180, 40870, 41010, 41480, 40090, 41500, 41460, 41440, 41310, 40360, 41320, 41210,
      40530, 41220, 40660, 40800, 40710, 40460, 40730, 40040, 40160, 40850, 40680, 41700, 40260,
      40380, 40460
    ],
    "green": [
      40020, 41350, 40610, 41260, 40280, 40480, 40700, 40480, 41670, 40030, 41670, 41070, 41360,
      40170, 41510, 41160, 40380, 40260, 41700, 40680, 41400, 41690, 41120, 40300, 41270, 41080,
      40130, 40510, 41140, 40720, 40940, 40290
    ],
    "red": [
      40900, 41190, 40100, 41300, 40760, 40880, 41380, 40340, 41200, 40770, 40540, 40080, 41420,
      41320, 41220, 40650, 40630, 41450, 40330, 41660, 41090, 40560, 41490, 41400, 41000, 40190,
      41230, 41170, 40910, 40990, 40240, 41430, 40450
    ],
    "orange": [
      40930, 40960, 41150, 40310, 40120, 41060, 41130, 41400, 40850, 40160, 40040, 40730, 40380,
      40260, 41700, 40680, 41400
    ],
    "blue": [
      40890, 40820, 40230, 40750, 41280, 41330, 40550, 41240, 40060, 41020, 40570, 40670, 40590,
      40320, 41410, 40490, 40380, 40370, 40790, 40070, 41340, 40430, 40350, 40470, 40810, 40220,
      40250, 40920, 40970, 40010, 40180, 40980, 40390
    ],
    "pink": [
      40580, 40420, 40600, 40150, 40780, 41040, 40440, 40740, 40210, 40830, 41030, 40170, 41510,
      41160, 40380, 40260, 41700, 40680, 40850, 40160, 40040, 40730, 41160
    ],
    "purple": [
      41050, 41250, 40400, 40520, 40050, 40690, 40270, 40840, 40900, 40540, 41320, 41210, 40530,
      41220, 40660, 40800, 40710, 40460, 40730, 40040, 40160, 40850, 40680, 41700, 40260, 40380, 40460
    ]
]