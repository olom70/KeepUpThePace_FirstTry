import 'package:args/args.dart';
import 'package:KeepUpThePace/KeepUpThePace.dart' as keepupthepace;
import 'package:KeepUpThePace/CompendiumOfPhysicalActivities.dart' as compendium;

ArgResults argResults;

void main(List<String> arguments) {
  final ArgParser argParser = new ArgParser()
    ..addOption('Profilename', abbr: 'n', defaultsTo: 'Claude?', help: "Name the profile")
    ..addOption('ProfileGoal', abbr: 'g', defaultsTo: 'Know my weekly needs', help: "What will be the use of this profile")
    ..addOption('MetricChoice', abbr: 'm', defaultsTo: 'iso', help: "Metric : Imperial or Iso ?")
    ..addOption('DefaultProfile', abbr: 'd', defaultsTo: 'Yes', help: "Define the profile as the default one loaded on start")
    ..addOption('Weight', abbr: 'e', defaultsTo: '67', help: "Your Weight")
    ..addOption('HeightIntegerPart', abbr: 'h', defaultsTo: '1', help: 'Your Height Integer part' )
    ..addOption('HeightDecimalPart', abbr: 't', defaultsTo: '72', help: 'Your Height (Decimal part)')
    ..addOption('Age', abbr: 'a', defaultsTo: '48', help: 'Your age')
    ..addOption('Wrist', abbr: 'r', defaultsTo: '16.5', help: 'Size of your wrist')
    ..addOption('Forearm', abbr: 'f', defaultsTo: '26', help: 'Length of your forearm')
    ..addOption('Waist', abbr: 's', defaultsTo: '92', help: 'Size of your Waist')
    ..addOption('Hips', abbr: 'i', defaultsTo: '91', help: 'Size of your Hips')
    ..addOption('Gender', abbr: 'w', defaultsTo: 'M', help: '(M)an or (W)oman ?')
    ..addOption('ActivityFactor', abbr: 'y', defaultsTo: 'lightlyActive', help: 'Your activity Factor')
    ..addFlag('help', abbr: 'p', negatable: false, help: 'Displays this help information.');

    argResults = argParser.parse(arguments);

    if (argResults['help']) {
    print("""
        ** HELP **
        ${argParser.usage}
        """);
  }

  // taking into account the arguments
    final String profileName = argResults['Profilename'];
    final String profileGoal = argResults['ProfileGoal'];
    final String metricChoice = argResults['MetricChoice'];
    final String defaultProfile = argResults['DefaultProfile'];
    final double weight = double.parse(argResults['Weight']);
    final int heightIntegerPart = int.parse(argResults['HeightIntegerPart']);
    final int heightDecimalPart = int.parse(argResults['HeightDecimalPart']);
    final int age = int.parse(argResults['Age']);
    final double wrist = double.parse(argResults['Wrist']);
    final double forearm = double.parse(argResults['Forearm']);
    final double waist = double.parse(argResults['Waist']);
    final double hips = double.parse(argResults['Hips']);
    final String gender = argResults['Gender'];
    final String activityFactor = argResults['ActivityFactor'];

    // setting the profile facts
    keepupthepace.Profile profile = new keepupthepace.Profile(profileName)
    ..weight = weight
    ..heightIntegerPart = heightIntegerPart
    ..heightDecimalPart = heightDecimalPart
    ..metricChoice = metricChoice
    ..age = age
    ..gender = gender
    ..activityFactor = activityFactor
    ..wrist = wrist
    ..waist = waist
    ..hips = hips;

    // infering the metrics of the current profile
    try {
      profile.computeBMI();
    }
    catch(e) {
      print('profile.computeBMI :');
      print (e.errMsg());
    }

    try {
      profile.computeHBE();
    }
    catch(e) {
      print('profile.computeHBE :');
      print (e.errMsg());
    }

    try {
      profile.computeFat();
    }
    catch(e) {
      print('profile.computeFat :');
      print (e.errMsg());
    }

    try {
      profile.computeRatio();
    }
    catch(e) {
      print('profile.computeRatio :');
      print (e.errMsg());
    }

    profile.computeRMR(1918);
    print(profile.rRMRcal);

    profile.computeRMR(1984);
    print(profile.rRMRcal);

    profile.computeRMR(1990);
    print(profile.rRMRcal);


    //profile.verify();

}
