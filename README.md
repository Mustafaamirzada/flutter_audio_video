# audio_image

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   final file = File(result.files.single.path!);
    //   audioplayer.setSourceAsset(file.path);
    // }







  int _selectedIndex = 0;

  final List<Widget> widgetOptions = const [
    Image(),
    Audio(),
    Video(),
  ];



          bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent.shade400,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.image),
            label: 'Image',
          ),
          NavigationDestination(
            icon: Icon(Icons.audiotrack_outlined),
            label: 'Audio',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            label: 'Video',
          )
        ],
        selectedIndex: _selectedIndex,
      ),
      body: <Widget>[
        Image(),
        Audio(),
        Video(),
      ][_selectedIndex],