class Files {
   String id , userId , fileUrl , date, category , subject;

   Files({ this.id ,this.userId , this.fileUrl ,
            this.subject, this.date ,this.category});

   Files.fromJSON(Map<String , dynamic> json){
    fileUrl = json['fileUrl'];
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    category = json['category'];
    subject = json['subject'];
   }
  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'fileUrl' : fileUrl,
      'userId': userId,
      'date': date,
      'category': category,
      'subject': subject,
    };
  }
}
