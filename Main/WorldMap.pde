//Zemyna 05/04/2021 20:24

class WorldMap
{
  PImage image;
  
  WorldMap()
  {
    image = worldMapImage;
  }
  
  void draw()
  {
    //header
    stroke(57, 57, 57);
    textFont(loadFont("ProcessingSansPro-Regular-78.vlw"));
    fill(193, 193, 193);
    rect(70, 70, 1470, 103);
    fill(209, 209, 209);
    rect(80, 80, 1450, 83);
    fill(46, 46, 46);
    textSize(78);
    text("Covid-19 Cases in the World", 100, 150);
    //map tab
    fill(193, 193, 193);
    rect(70, 200, 1487, 789); 
    fill(107, 108, 147);
    rect(80, 210, 1467, 769);
    tint(222,223,252);
    image(image, 90, 220);
    //info tab
    fill(193, 193, 193);
    rect(1557, 200, 288, 789); 
    fill(107, 108, 147);
    rect(1567, 210, 268, 769);
    fill(237, 237, 237);
    textFont(largeFont);
    textSize(36);
    text("Information In", 1590, 250);
    fill(237, 237, 237);
    rect(1580, 270, 240, 3);
    textSize(24);
    text("formation Information", 1590, 310);
    text("Information Informati", 1590, 340);
    text("on Information Inform", 1590, 370);
    text("ation Information Inf", 1590, 400);
    text("ormation Information ", 1590, 430);
    text("Information Informati", 1590, 460);
    text("on Information Inform", 1590, 490);
    
    //rectangle indexes for each country
    /*
    fill(234,107,107); 
    rect(1020,425,35,20);//Afghanistan
    rect(850,398,3,9);//Albania  
    rect(770,430,35,65);//Algeria  
    rect(773,395,3,3);//Andorra 
    rect(825,630,35,40);//Angola 
    rect(513,510,3,3);//Antigua and Barbuda 
    rect(500,710,30,80);//Argentina 
    rect(950,405,6,6);//Armenia  
    rect(1240,690,130,50);//Australia   
    rect(825,370,15,7);//Austria 
    rect(958,400,9,9);//Azerbaijan   
    rect(458,480,3,3);//Bahamas 
    rect(970,470,3,3);//Bahrain  
    rect(1130,480,10,10);//Bangladesh 
    rect(520,530,3,3);//Barbados  
    rect(870,340,30,20);//Belarus 
    rect(785,355,9,7);//Belgium 
    rect(403,510,10,20);//Belize 
    rect(779,540,5,25);//Benin  
    rect(1130,465,9,5);//Bhutan 
    rect(495,650,40,50); //Bolivia 
    rect(840,385,8,7);//Bosnia and Herzegovina 
    rect(855,680,30,30);//Botswana  
    rect(510,600,100,70);//Brazil
    rect(1230,570,5,5);//Brunei 
    rect(865,390,15,10);//Bulgaria   
    rect(755,525,20,20);//Burkina Faso  
    rect(888,610,5,5);//Burundi    
    rect(740,545,20,25);//Côte d'Ivoire
    rect(680,500,10,10);//Cabo Verde   
    rect(1185,530,20,20);//Cambodia   
    rect(810,550,25,30);//Cameroon   
    rect(210,280,300,90);//Canada   
    rect(830,550,50,30);//Central African Republic   
    rect(830,490,40,60);//Chad   
    rect(485,680,10,100);//Chile   
    rect(1070,380,190,80);//China   
    rect(458,550,40,40);//Colombia  
    rect(940,640,10,10);//Comoros   
    rect(830,580,10,40);//Congo (Congo-Brazzaville)  
    rect(430,540,10,10);//Costa Rica  
    rect(830,380,10,10);//Croatia   
    rect(430,480,40,30);//Cuba   
    rect(900,430,10,10);//Cyprus  
    rect(820,360,25,10);//Czechia (Czech Republic)  
    rect(850,570,40,60);//Democratic Republic of the Congo   
    rect(800,330,20,20);//Denmark   
    rect(935,530,10,10);//Djibouti   
    rect(510,520,10,10);//Dominica   
    rect(500,510,10,10);//Dominican Republic   
    rect(450,590,20,20);//Ecuador   
    rect(870,450,40,40);//Egypt   
    rect(410,525,10,10);//El Salvador   
    rect(810,580,10,10);//Equatorial Guinea  
    rect(920,510,10,20);//Eritrea   
    rect(865,320,20,10);//Estonia   
    rect(895,710,10,10);//Eswatini (fmr. "Swaziland") 
    rect(910,530,40,40);//Ethiopia   
    rect(1480,670,10,10);//Fiji   
    rect(870,280,20,40);//Finland  
    rect(760,360,40,30);//France   
    rect(810,580,20,20);//Gabon   
    rect(710,530,20,10);//Gambia   
    rect(940,390,20,10);//Georgia   
    rect(800,340,30,30);//Germany   
    rect(760,545,15,25);//Ghana   
    rect(855,400,20,20);//Greece
    rect(530,240,150,50);//Greenland
    rect(500,520,10,10);//Grenada   
    rect(400,510,20,15);//Guatemala   
    rect(710,540,30,10);//Guinea   
    rect(710,530,10,10);//Guinea-Bissau   
    rect(530,560,10,30);//Guyana   
    rect(490,510,10,10);//Haiti   
    rect(820,395,5,5);//Holy See  (Vatican) 
    rect(420,515,20,15);//Honduras   
    rect(840,370,20,10);//Hungary   
    rect(680,290,40,10);//Iceland   
    rect(1060,460,60,80);//India   
    rect(1170,590,170,40);//Indonesia   
    rect(960,420,60,50);//Iran  
    rect(930,420,30,30);//Iraq   
    rect(735,340,10,20);//Ireland   
    rect(910,440,10,10);//Israel   
    rect(810,380,20,30);//Italy   
    rect(480,500,10,10);//Jamaica   
    rect(1300,420,40,20);//Japan   
    rect(920,440,10,20);//Jordan   
    rect(970,350,150,40);///Kazakhstan   
    rect(910,570,30,40);//Kenya   
    rect(1500,640,3,3);//Kiribati   
    rect(960,450,10,10);//Kuwait  
    rect(1060,390,30,20);//Kyrgyzstan   
    rect(1180,490,10,30);//Laos   
    rect(860,325,20,10);//Latvia   
    rect(910,430,10,10);//Lebanon   
    rect(880,730,10,10);//Lesotho   
    rect(730,555,10,20);//Liberia   
    rect(810,440,60,60);//Libya   
    rect(810,375,3,3);//Liechtenstein   
    rect(860,335,20,10);//Lithuania   
    rect(795,360,5,5);//Luxembourg   
    rect(950,660,20,50);//Madagascar   
    rect(900,640,10,30);//Malawi   
    rect(1175,560,10,30);//Malaysia   
    rect(1070,570,5,5);//Maldives   
    rect(740,480,50,40);//Mali   
    rect(825,425,5,5);//Malta  
    rect(1500,570,10,10);//Marshall Islands   
    rect(720,470,30,50);//Mauritania   
    rect(980,680,5,5);//Mauritius   
    rect(330,450,50,60);//Mexico   
    rect(1360,570,5,5);//Micronesia   
    rect(880,370,10,10);//Moldova 
    rect(800,390,5,5);//Monaco  
    rect(1130,360,120,40);//Mongolia   
    rect(850,395,5,5);//Montenegro  
    rect(740,430,20,30);//Morocco  
    rect(910,650,20,50);//Mozambique   
    rect(1150,470,20,50);//Myanmar (formerly Burma)   
    rect(825,670,30,50);//Namibia   
    rect(1450,590,5,5);//Nauru   
    rect(1090,455,40,10);//Nepal  
    rect(790,350,10,10);//Netherlands  
    rect(1450,780,30,20);//New Zealand  
    rect(420,530,20,10);//Nicaragua 
    rect(790,490,50,40);//Niger   
    rect(790,530,40,40);//Nigeria   
    rect(1270,400,20,20);//North Korea  
    rect(850,400,10,10);//North Macedonia  
    rect(800,300,20,30);//Norway  
    rect(990,480,20,30);//Oman   
    rect(1020,440,40,40);//Pakistan
    rect(1320,540,5,5);//Palau   
    rect(910,440,5,10);//Palestine
    rect(440,550,20,10);//Panama  
    rect(1340,610,30,30);//Papua New Guinea   
    rect(520,680,20,30);//Paraguay  
    rect(450,610,30,40);//Peru   
    rect(1250,500,20,60);//Philippines   
    rect(830,340,40,30);//Poland   
    rect(735,400,10,20);//Portugal   
    rect(975,470,5,5);//Qatar   
    rect(860,370,20,20);//Romania  
    rect(900,270,600,90);//Russia  
    rect(890,600,10,10);//Rwanda  
    rect(540,520,10,10);//Saint Kitts and Nevis 
    rect(520,530,10,10);//Saint Lucia   
    rect(525,540,10,10);//Saint Vincent and the Grenadines  
    rect(1510,650,5,5);//Samoa   
    rect(820,390,5,5);//San Marino  
    rect(790,580,5,5);//Sao Tome and Principe  
    rect(920,460,60,50);//Saudi Arabia  
    rect(710,520,10,10);//Senegal  
    rect(850,380,10,20);//Serbia  
    rect(980,590,5,5);//Seychelles 
    rect(720,550,10,10);//Sierra Leone   
    rect(1185,580,5,5);//Singapore 
    rect(840,360,20,10);//Slovakia   
    rect(825,380,10,10);//Slovenia  
    rect(1380,620,30,10);//Solomon Islands  
    rect(940,540,30,40);//Somalia   
    rect(840,720,60,30);//South Africa 
    rect(1280,420,10,10);//South Korea  
    rect(870,550,40,30);//South Sudan   
    rect(745,390,40,40);//Spain  
    rect(1090,550,10,20);//Sri Lanka 
    rect(870,490,50,60);//Sudan   
    rect(545,565,10,20);//Suriname   
    rect(830,280,20,50);//Sweden   
    rect(800,370,10,10);//Switzerland   
    rect(910,425,30,20);//Syria  
    rect(1050,410,20,10);//Tajikistan
    rect(890,600,40,50);//Tanzania  
    rect(1160,500,30,30);//Thailand   
    rect(1260,640,5,5);//Timor-Leste  
    rect(770,540,5,30);//Togo  
    rect(1500,680,10,10);//Tonga 
    rect(540,550,10,10);//Trinidad and Tobago 
    rect(805,420,10,30);//Tunisia 
    rect(880,400,70,20);//Turkey
    rect(985,400,40,20);//Turkmenistan  
    rect(1510,660,10,10);//Tuvalu  
    rect(890,580,20,20);//Uganda  
    rect(870,350,50,30);//Ukraine
    rect(980,480,20,10);//United Arab Emirates  
    rect(750,330,20,30);//United Kingdom  
    rect(280,370,190,90); rect(110,280,100,50);//United States of America   
    rect(540,735,20,20);//Uruguay  
    rect(1000,380,40,30);//Uzbekistan  
    rect(1440,660,10,20);//Vanuatu  
    rect(490,540,35,40);//Venezuela  
    rect(1200,520,10,20);//Vietnam   
    rect(940,510,40,20);//Yemen  
    rect(860,640,50,30);//Zambia 
    rect(880,670,25,25);//Zimbabwe 
    */
  }
}
