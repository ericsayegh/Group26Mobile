import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends Page"),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://www.verywellfit.com/thmb/LeBe7RNtzbJwyKRmH8ditmJ1NKg=/1500x1020/filters:no_upscale():max_bytes(150000):strip_icc()/Snapwire-Running-27-66babd0b2be44d9595f99d03fd5827fd.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.blue,
                width: 8,
              )),
          width: double.infinity,
          height: double.infinity,
          child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RowView("Friends $index", index * 2, index);
                  },
                ),
              ],
            ),
          )),
    );
  }
}

class RowView extends StatelessWidget {
  String name;
  int profileCount, removedCount;

  RowView(this.name, this.profileCount, this.removedCount, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Profile"),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Remove"),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
