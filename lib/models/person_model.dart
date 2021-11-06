class Person {
   String id ,  pass , friend , imageUrl;
   List <Person> favourites = [];
   List<String>location = [];
   String name , job ,catagory , about , education ,
       experience , country, city , area ,vilige;
    List<String> gallaries = [];
    String phone, whatsapp, facebook , tweater, linkedin, mail ,youtube;
   Person({
    this.id, this.friend,this.imageUrl,this.favourites,this.country,this.city,
    this.name,this.about, this.catagory,this.education,this.experience,this.vilige,
     this.phone,this.whatsapp, this.facebook,this.tweater,this.linkedin,this.pass,
     this.mail ,this.gallaries, this.job, this.youtube
  });

   Person.fromJSON(Map<String , dynamic> json){
    id = json['id'];              name = json['name'];          pass = json['pass'];
    about = json['about'];        gallaries = json['gallaries'];
    friend = json['friend'];      education = json['education'];
    imageUrl = json['imageUrl'];  job = json['job'];
    favourites = json['favourites']; catagory = json['catagory'];
    country = json['country'];       city = json['city'];
    vilige = json['vilige'];    experience = json['experience'];
    phone = json['phone'];  whatsapp = json['whatsapp'];
    facebook = json['facebook']; tweater = json['tweater'];
    linkedin = json['linkedin'];     mail = json['mail'];  youtube = json['youtube'];
  }
  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'pass' : pass,
      'friend':friend,
      'imageUrl' : imageUrl,
      'favourites': favourites,
      'about': about,
      'country': country,
      'city': city,
      'vilige': vilige,
      'experience': experience,
      'catagory': catagory,
      'job': job,
      'education': education,
      'name': name,
      'gallaries': gallaries,
      'phone': phone,
      'whatsapp': whatsapp,
      'facebook': facebook,
      'tweater': tweater,
      'linkedin': linkedin,
      'mail': mail,
      'youtube': youtube,
    };
  }
}
