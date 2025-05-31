import 'dart:convert';

class Answer {
  int? questionId;
  var value;
  int? type;
  int price=0;
  int time=0;
  int? nextQuestionIndex;
  int? preQuestionIndex;

  Answer({ this.questionId,this.type,this.value,this.price=0,this.time=0});

  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    if(type==2){
      List<String> images=[];
      if(this.value!=null){
        this.value.forEach((elm)=>images.add(base64.encode(elm)));
      }
      data['count']=images.length;
      for(int i=0;i<images.length;i++){
        data['value${i}'] =images[i];
      }
      data['value']=images;
    }else if(type==3){
      List<int> res=[];
      this.value.forEach((elm) {
        print('>>>>>type3>>>>>$elm');
        return res.add(elm);
      });
      data['count']=res.length;
      for(int i=0;i<res.length;i++){
        data['value${i}']=res[i];
      }
      data['value']=this.value;
    }
    else
      data['value'] = this.value;
    return data;
  }
}
