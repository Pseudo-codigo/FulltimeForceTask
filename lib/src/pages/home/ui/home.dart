import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/shared/routes/routes.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
      ),
      body: EasyRefresh.builder(
        header: const MaterialHeader(),
        footer: NotLoadFooter(),
        onRefresh: () async {
          return IndicatorResult.success;
        },
        onLoad: () async {},
        childBuilder: (context, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Container(
                                          margin: const EdgeInsets.all(8.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Richie Lorie",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                  onPressed: () {},
                                  heroTag: 'follow',
                                  elevation: 0,
                                  label: const Text("Branches"),
                                  icon: const Icon(Icons.commit),
                                ),
                                const SizedBox(width: 16.0),
                                FloatingActionButton.extended(
                                  onPressed: () {
                                    context.pushNamed(Routes.settings);
                                  },
                                  heroTag: 'settings',
                                  elevation: 0,
                                  backgroundColor: Colors.red,
                                  label: const Text("Settings"),
                                  icon: const Icon(Icons.settings),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 80,
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    rowItem(
                                        context: context,
                                        name: 'Issues',
                                        value: '3'),
                                    rowItem(
                                        context: context,
                                        name: 'Default',
                                        separator: true),
                                    rowItem(
                                        context: context,
                                        name: 'Stars',
                                        separator: true),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget rowItem({
    required BuildContext context,
    String name = "",
    String value = "",
    bool separator = false,
  }) {
    return Expanded(
        child: Row(
      children: [
        if (separator) const VerticalDivider(),
        Expanded(child: _singleItem(context, name, value)),
      ],
    ));
  }

  Widget _singleItem(BuildContext context, String name, String value) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}
