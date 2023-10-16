import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_architecture/src/presentation/widgets/loading_column.dart';

import '../cubit/authentication_cubit.dart';
import '../widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating users')
                  : state is UsersLoaded
                      ? Scrollbar(
                          child: Center(
                            child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                print('User Avatar: ${user.avatar}');
                                return ListTile(
                                  leading: Image.network(user.avatar),
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt.substring(9)),
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AddUserDialog(nameController: nameController),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User'),
          ),
        );
      },
    );
  }
}
