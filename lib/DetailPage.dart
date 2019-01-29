import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.data, this.index);
  Color mainColor = Color.fromARGB(255, 2, 4, 15);
  Color textBody = Color(0xFF9b9b9a);
  final data;
  final int index;
  @override
  Widget build(BuildContext context) {
    String image = data["image"];
    return Scaffold(
        backgroundColor: mainColor,        
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: mainColor,
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  data["alias"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'BebasNeue-Regular',
                      fontSize: 16,
                      shadows: [Shadow(blurRadius: 20.0, color: Colors.black)]),
                ),
                background: Hero(
                  tag: "superhero$index",
                  child: Image.asset(
                    "assets/$image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                HeroContainer(
                    data["real_name"], Icons.account_circle, textBody),
                HeroContainer(
                    data["birth_date"], Icons.calendar_today, textBody),
                HeroContainer(data["gender"] == 1 ? "Masculino" : "Femenino",
                    Icons.wc, textBody),
                HeroContainer("Historia", Icons.info, textBody),
                Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 13, 31, 45),
                    /*boxShadow: [
                        BoxShadow(blurRadius: 8,color: Colors.blue)
                      ]*/
                  ),
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                  child: ListTile(
                    title: Text(
                      data["history"],
                      style: TextStyle(
                          color: textBody, fontFamily: 'BebasNeue-Regular'),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }
}

class HeroContainer extends StatelessWidget {
  final String title;
  IconData icono;
  Color textBody;
  HeroContainer(this.title, this.icono, this.textBody);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 31, 45),
      ),
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: ListTile(
        leading: Icon(icono, size: 40, color: textBody),
        title: Text(title,
            style: TextStyle(
              color: textBody,
              fontFamily: 'BebasNeue-Regular',
            )),
      ),
    );
  }
}
