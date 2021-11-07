class Files {
   String id , userId , fileUrl , date;

   Files({ this.id ,this.userId , this.fileUrl , this.date});

   Files.fromJSON(Map<String , dynamic> json){
    fileUrl = json['imageUrl'];
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
  }
  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'imageUrl' : fileUrl,
      'userId': userId,
      'date': date,
    };
  }
}
