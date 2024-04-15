import 'package:defensa_civil/home/home.dart';
import 'package:defensa_civil/pages/about/about.dart';
import 'package:defensa_civil/pages/addsituation/formsituation.dart';
import 'package:defensa_civil/pages/be_volunteer/be_volunteer.dart';
import 'package:defensa_civil/pages/change_password/change_password.dart';
import 'package:defensa_civil/pages/hostels/hostels.dart';
import 'package:defensa_civil/pages/hostels_map/hostels_map.dart';
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:defensa_civil/pages/login/login.dart';
import 'package:defensa_civil/pages/members/members.dart';
import 'package:defensa_civil/pages/news/news.dart';
import 'package:defensa_civil/pages/preventive_measures/preventive_measures.dart';
import 'package:defensa_civil/pages/services/services.dart';
import 'package:defensa_civil/pages/situations_map/situation_map_body.dart';
import 'package:defensa_civil/pages/story/story.dart';
import 'package:defensa_civil/pages/videos/videos.dart';
import 'package:defensa_civil/pages/getsituation/getsituation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/Specific_news/Specific_news.dart';

class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: Colors.blue.shade700,
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(children: [
        const CircleAvatar(
          radius: 52,
          backgroundImage: AssetImage("assets/images/logo_dc.png"),
        ),
        const SizedBox(height: 12),
        const Text(
          "Defensa Civil",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        Text(
          "Bienvenido/a ${authProvider.nombre ?? ""}",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        )
      ]),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            const Text(
              "General",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue,
                  fontWeight: FontWeight.w700),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Inicio"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb_outlined),
              title: const Text("Servicios"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Services())),
            ),
            ListTile(
              leading: const Icon(Icons.groups_outlined),
              title: const Text("Miembros"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Members())),
            ),
            ListTile(
              leading: const Icon(Icons.apartment_outlined),
              title: const Text("Historia"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Story())),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper_outlined),
              title: const Text("Noticias"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const News())),
            ),
            ListTile(
              leading: const Icon(Icons.videocam_outlined),
              title: const Text("Videos"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Videos())),
            ),
            ListTile(
              leading: const Icon(Icons.gite),
              title: const Text("Albergues"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Hostels())),
            ),
            ListTile(
              leading: const Icon(Icons.map_outlined),
              title: const Text("Mapa de Albergues"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HostelsMap())),
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text("Medidas Preventivas"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const PreventiveMeasures())),
            ),
            const Divider(
              color: Colors.black54,
            ),
            if (authProvider.isAuthenticated) ...{
              const Text(
                "Opciones de Perfil",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700),
              ),
              ListTile(
                leading: const Icon(Icons.newspaper_outlined),
                title: const Text("Noticias Especificas"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const SpecificNews())),
              ),
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text("Reportar Situación"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const Fsituation())),
              ),
              ListTile(
                leading: const Icon(Icons.announcement_outlined),
                title: const Text("Mis Situaciones"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const GSituation())),
              ),
              ListTile(
                leading: const Icon(Icons.map_outlined),
                title: const Text("Mapa Situaciones"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const SituationsMap())),
              ),
              const Divider(
                color: Colors.black54,
              ),
            },
            if (authProvider.isAuthenticated)
              ListTile(
                iconColor: Colors.indigo.shade500,
                textColor: Colors.indigo.shade500,
                leading: const Icon(Icons.password),
                title: const Text("Cambiar Contraseña"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword())),
              ),
            ListTile(
              iconColor: Colors.blue.shade700,
              textColor: Colors.blue.shade700,
              leading: const Icon(Icons.volunteer_activism_outlined),
              title: const Text("Quiero Ser Voluntario"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const BeVolunteer())),
            ),
            ListTile(
              iconColor: Colors.orange.shade800,
              textColor: Colors.orange.shade800,
              leading: const Icon(Icons.info_outline),
              title: const Text("Acerca de"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const About())),
            ),
            if (!authProvider.isAuthenticated)
              ListTile(
                iconColor: Colors.green.shade700,
                textColor: Colors.green.shade700,
                leading: const Icon(Icons.login),
                title: const Text("Iniciar Sesión"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login())),
              ),
            if (authProvider.isAuthenticated)
              ListTile(
                iconColor: Colors.red.shade800,
                textColor: Colors.red.shade800,
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Cerrar Sesión"),
                onTap: () async {
                  if (authProvider.isAuthenticated) {
                    authProvider.logout();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sesión finalizada')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No has iniciado sesión.')),
                    );
                  }
                },
              )
          ],
        ));
  }
}
