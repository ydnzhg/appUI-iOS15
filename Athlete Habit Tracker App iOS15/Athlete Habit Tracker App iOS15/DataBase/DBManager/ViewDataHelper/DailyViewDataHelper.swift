//
//  DailyViewDataHelper.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by 叶建锋 on 2022/6/8.
//

import Foundation

class DailyViewDataHelper: ObservableObject {
    @Published var optionsArray:[TraceOptionsDataModel]
    var detailArray:[TraceOptionsDetailDataModel]
    var useDate : Date
    //today
    init(detail : Bool, date: Date)
    {
        if(!SQLiteDataStore.sharedInstance.initOk)
        {
            try! SQLiteDataStore.sharedInstance.createTables();
        }
        
        self.optionsArray = try! TraceOptionsDataHelper.findAll()!;
        useDate = date;
        self.detailArray = try! TraceOptionsDetailDataHelper.findOneDay(date: date);
        if(self.detailArray.isEmpty)
        {
            self.optionsArray[0].inputScore = 0;
            self.optionsArray[1].inputScore = 0;
            self.optionsArray[2].inputScore = 0;
            self.optionsArray[3].inputScore = 0;
            self.optionsArray[4].inputScore = 0;
            self.optionsArray[5].inputScore = 0;
            self.optionsArray[6].inputScore = 0;
            self.optionsArray[7].inputScore = 0;
        }else
        {
            self.optionsArray[0].inputScore = self.detailArray[0].inputScore;
            self.optionsArray[1].inputScore = self.detailArray[1].inputScore;
            self.optionsArray[2].inputScore = self.detailArray[2].inputScore;
            self.optionsArray[3].inputScore = self.detailArray[3].inputScore;
            self.optionsArray[4].inputScore = self.detailArray[4].inputScore;
            self.optionsArray[5].inputScore = self.detailArray[5].inputScore;
            self.optionsArray[6].inputScore = self.detailArray[6].inputScore;
            self.optionsArray[7].inputScore = self.detailArray[7].inputScore;
        }
        self.optionsArray[0].palette = .lighterpurple;
        self.optionsArray[1].palette = .royalblue;
        self.optionsArray[2].palette = .orangehibiscus;
        self.optionsArray[3].palette = .maximumbluegreen;
        self.optionsArray[4].palette = .reptilegreen;
        self.optionsArray[5].palette = .fusionred;
        self.optionsArray[6].palette = .bluegrey;
        self.optionsArray[7].palette = .bluehorizon;
    }
    func getDetailScore(date: Date,optionId: Int) -> Int
    {
        do{
            let data = try TraceOptionsDetailDataHelper.findOneDay(date: date, optionId: optionId);
            return data.inputScore;
            

        }catch _ {
            print("inster userModel error")
        }
        
        return 0;
    }
    func updateGoal() -> Void
    {
        let tmp : [TraceOptionsDataModel]
        tmp = try! TraceOptionsDataHelper.findAll()!;
        if tmp.count > 0
        {
            for index in 0 ... tmp.count - 1
            {
                self.optionsArray[index].goal = tmp[index].goal
            }
        }
    }
    func changeDate(date:Date) -> Void
    {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = timeFormatter.string(from: date)
        let currentDate = timeFormatter.string(from: useDate)
        if(dateStr == currentDate) {
            return
        }
        useDate = date;
        self.detailArray = try! TraceOptionsDetailDataHelper.findOneDay(date: date);
        if(self.detailArray.isEmpty)
        {
            self.optionsArray[0].inputScore = 0;
            self.optionsArray[1].inputScore = 0;
            self.optionsArray[2].inputScore = 0;
            self.optionsArray[3].inputScore = 0;
            self.optionsArray[4].inputScore = 0;
            self.optionsArray[5].inputScore = 0;
            self.optionsArray[6].inputScore = 0;
            self.optionsArray[7].inputScore = 0;
        }else
        {
            //alter EnrtyInputView  value
            self.optionsArray[0].inputScore = self.detailArray[0].inputScore;
            self.optionsArray[1].inputScore = self.detailArray[1].inputScore;
            self.optionsArray[2].inputScore = self.detailArray[2].inputScore;
            self.optionsArray[3].inputScore = self.detailArray[3].inputScore;
            self.optionsArray[4].inputScore = self.detailArray[4].inputScore;
            self.optionsArray[5].inputScore = self.detailArray[5].inputScore;
            self.optionsArray[6].inputScore = self.detailArray[6].inputScore;
            self.optionsArray[7].inputScore = self.detailArray[7].inputScore;
        }
        
    }
    func commitToOptionsDetailDB()-> Bool {
        do {
            if(self.detailArray.isEmpty)
            {
                let id0 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel0 = TraceOptionsDetailDataModel(detailID: id0, optionId: optionsArray[0].dataID, optionName:optionsArray[0].title,inputScore: optionsArray[0].inputScore, score: 0,unit:optionsArray[0].unit,createTime:useDate);
                var r = try TraceOptionsDetailDataHelper.insert(item: detailModel0 );
                
                
                let id1 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel1 = TraceOptionsDetailDataModel(detailID: id1, optionId: optionsArray[1].dataID, optionName:optionsArray[1].title,inputScore: optionsArray[1].inputScore, score: 0,unit:optionsArray[1].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel1 );
                
                let id2 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel2 = TraceOptionsDetailDataModel(detailID: id2, optionId: optionsArray[2].dataID, optionName:optionsArray[2].title,inputScore: optionsArray[2].inputScore, score: 0,unit:optionsArray[2].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel2 );
                
                let id3 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel3 = TraceOptionsDetailDataModel(detailID: id3, optionId: optionsArray[3].dataID, optionName:optionsArray[3].title,inputScore: optionsArray[3].inputScore, score: 0,unit:optionsArray[3].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel3 );
                
                let id4 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel4 = TraceOptionsDetailDataModel(detailID: id4, optionId: optionsArray[4].dataID, optionName:optionsArray[4].title,inputScore: optionsArray[4].inputScore, score: 0,unit:optionsArray[4].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel4 );
                
                let id5 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel5 = TraceOptionsDetailDataModel(detailID: id5, optionId: optionsArray[5].dataID, optionName:optionsArray[5].title,inputScore: optionsArray[5].inputScore, score: 0,unit:optionsArray[5].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel5 );
                
                let id6 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel6 = TraceOptionsDetailDataModel(detailID: id6, optionId: optionsArray[6].dataID, optionName:optionsArray[6].title,inputScore: optionsArray[6].inputScore, score: 0,unit:optionsArray[6].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel6 );
                
                let id7 = try TraceOptionsDetailDataHelper.getNewId()
                let  detailModel7 = TraceOptionsDetailDataModel(detailID: id7, optionId: optionsArray[7].dataID, optionName:optionsArray[7].title,inputScore: optionsArray[7].inputScore, score: 0,unit:optionsArray[7].unit,createTime:useDate);
                r = try TraceOptionsDetailDataHelper.insert(item: detailModel7 );
                
                return r != 0;
            }else
            {
                var i = 0;
                for var item in  detailArray {
                    if(i >= optionsArray.count)
                    {
                        break;
                    }
                    item.inputScore = optionsArray[i].inputScore;
                    try TraceOptionsDetailDataHelper.update(item: item)
                    i += 1;
                }
            }
            return true
        } catch _ {
            print("inster userModel error")
        }
        return false
    }
}
