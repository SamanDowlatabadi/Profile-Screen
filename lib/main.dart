import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:profile_screen/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool themeMode = true;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fa'), // Farsi
      ],
      locale: _locale,
      title: 'Flutter Demo',
      theme: themeMode
          ? MyConfigThemeData.dark().themeData(_locale.languageCode)
          : MyConfigThemeData.light().themeData(_locale.languageCode),
      home: ProfileScreen(selectedLanguageByUser: (Language newLanguageByUser) {
        setState(() {
          _locale = newLanguageByUser == Language.en
              ? const Locale('en')
              : const Locale('fa');
        });
      }, toggleTheme: () {
        setState(() {
          themeMode = !themeMode;
        });
      }),
    );
  }
}



class ProfileScreen extends StatefulWidget {
  final Function() toggleTheme;
  final Function(Language) selectedLanguageByUser;

  const ProfileScreen(
      {super.key,
      required this.toggleTheme,
      required this.selectedLanguageByUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SkillType _skillType = SkillType.photoshop;
  bool isLiked = false;
  Language _language = Language.en;

  void updateSkillType(SkillType skill) {
    setState(() {
      _skillType = skill;
    });
  }

  void updateSelectedLanguage(Language language) {
    widget.selectedLanguageByUser(language);
    setState(() {
      {
        _language = language;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalization = AppLocalizations.of(context)!;
    bool showCursor = false;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalization.profileTitle),
          actions: [
            InkWell(
              onTap: widget.toggleTheme,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Theme.of(context).brightness == Brightness.dark
                    ? const Icon(
                        Icons.sunny,
                        color: Colors.white,
                      )
                    : const Icon(
                        CupertinoIcons.moon_stars_fill,
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/profile_image.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalization.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            appLocalization.job,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 15,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .color,
                              ),
                              Text(
                                appLocalization.location,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      icon: Icon(
                        isLiked
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: Text(
                  appLocalization.summary,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 00),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalization.selectedLanguage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    CupertinoSlidingSegmentedControl<Language>(
                      thumbColor: Theme.of(context).primaryColor,
                      groupValue: _language,
                      children: {
                        Language.en: Text(
                          appLocalization.enLanguage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                        Language.fa: Text(
                          appLocalization.faLanguage,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                      },
                      onValueChanged: (value) =>
                          {if (value != null) updateSelectedLanguage(value)},
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 32, bottom: 16, right: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      appLocalization.skills,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ItemSkills(
                      imageAddress: 'assets/images/app_icon_01.png',
                      skillName: 'Photoshop',
                      shadowColor: Colors.indigo.shade800,
                      isActive: _skillType == SkillType.photoshop,
                      onTap: () {
                        updateSkillType(
                          SkillType.photoshop,
                        );
                      },
                    ),
                    ItemSkills(
                      imageAddress: 'assets/images/app_icon_02.png',
                      skillName: 'Lightroom',
                      shadowColor: Colors.indigo.shade800,
                      isActive: _skillType == SkillType.lightroom,
                      onTap: () {
                        updateSkillType(
                          SkillType.lightroom,
                        );
                      },
                    ),
                    ItemSkills(
                      imageAddress: 'assets/images/app_icon_03.png',
                      skillName: 'Aftereffect',
                      shadowColor: Colors.indigo.shade900,
                      isActive: _skillType == SkillType.aftereffect,
                      onTap: () {
                        updateSkillType(
                          SkillType.aftereffect,
                        );
                      },
                    ),
                    ItemSkills(
                      imageAddress: 'assets/images/app_icon_04.png',
                      skillName: 'Illustrator',
                      shadowColor: Colors.deepOrange.shade900,
                      isActive: _skillType == SkillType.illustrator,
                      onTap: () {
                        updateSkillType(
                          SkillType.illustrator,
                        );
                      },
                    ),
                    ItemSkills(
                      imageAddress: 'assets/images/app_icon_05.png',
                      skillName: 'Adobe XD',
                      shadowColor: Colors.pink.shade400,
                      isActive: _skillType == SkillType.adobeXD,
                      onTap: () {
                        updateSkillType(
                          SkillType.adobeXD,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalization.personalInformation,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      showCursor: showCursor,
                      decoration: InputDecoration(
                        labelText: appLocalization.email,
                        prefixIcon: const Icon(
                          Icons.alternate_email_sharp,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      showCursor: showCursor,
                      decoration: InputDecoration(
                        labelText: appLocalization.password,
                        prefixIcon: const Icon(
                          Icons.password,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          appLocalization.save,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSkills extends StatelessWidget {
  final String imageAddress;
  final String skillName;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const ItemSkills({
    super.key,
    required this.imageAddress,
    required this.skillName,
    required this.shadowColor,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 20,
                      ),
                    ])
                  : null,
              child: Image.asset(
                imageAddress,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              skillName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

enum SkillType {
  photoshop,
  lightroom,
  aftereffect,
  illustrator,
  adobeXD,
}

enum Language {
  fa,
  en,
}
