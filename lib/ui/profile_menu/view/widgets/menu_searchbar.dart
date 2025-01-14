import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import '../../cubit/menu_searchbar_cubit.dart';
import '../../cubit/menu_searchbar_state.dart';


class MenuSearchbar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBarCubit(),
      child: BlocBuilder<SearchBarCubit, SearchBarState>(
        builder: (context, state) {
          final cubit = context.read<SearchBarCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: state.isFocused ? context.colors.primary : Colors.grey,
                ),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _controller,
                cursorColor: context.colors.primary,
                onChanged: (value) {
                  cubit.updateSearchText(value);
                },
                decoration: InputDecoration(
                  hintText: state.isFocused || state.searchText.isNotEmpty
                      ? null 
                      : 'Search', 
                  hintStyle: TextStyle(
                    color: context.appColors.fDividerColor,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                  color: context.appColors.fDividerColor
                  ),
                  suffixIcon: state.searchText.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _controller.clear();
                            cubit.clearSearchText();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding:
                     const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                ),
                onTap: () {
                  cubit.setFocus(true);
                },
                onEditingComplete: () {
                  cubit.setFocus(false);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

