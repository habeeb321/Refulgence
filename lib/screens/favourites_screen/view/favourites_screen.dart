import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refulgence/core/constants.dart';
import 'package:refulgence/screens/detail_screen/view/detail_screen.dart';
import 'package:refulgence/screens/favourites_screen/controller/favourites_bloc.dart';
import 'package:refulgence/screens/favourites_screen/controller/favourites_event.dart';
import 'package:refulgence/screens/favourites_screen/controller/favourites_state.dart';
import 'package:refulgence/screens/home_screen/model/products_model.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(size),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(Size size) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'My Favourites',
        style: Constants.appBarTitleStyle(size),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    context.read<FavouritesBloc>().add(LoadFavouritesEvent());
    return BlocConsumer<FavouritesBloc, FavouritesState>(
      listener: (context, state) {
        if (state is FavouritesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<FavouritesBloc>().add(LoadFavouritesEvent());
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: _buildContent(state, context),
        );
      },
    );
  }

  Widget _buildContent(FavouritesState state, BuildContext context) {
    switch (state.runtimeType) {
      case FavouritesInitial:
      case FavouritesLoading:
        return const Center(child: CircularProgressIndicator());

      case FavouritesLoaded:
        final loadedState = state as FavouritesLoaded;
        return _buildFavouritesList(loadedState.favourites);

      case FavouritesError:
        final errorState = state as FavouritesError;
        return _buildErrorContent(errorState.message, context);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFavouritesList(List<ProductsModel> favourites) {
    if (favourites.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favourites.length,
      itemBuilder: (context, index) {
        final product = favourites[index];
        return _buildFavouriteCard(product, context);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 120,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 24),
          Text(
            'No Favourites Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade400,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start adding products to your favourites\nto see them here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteCard(ProductsModel product, BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.shade100),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade400, Colors.red.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        '${product.id}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product #${product.id}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'User: ${product.userId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<FavouritesBloc>().add(
                            RemoveFromFavouritesEvent(product.id!),
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Removed from favourites'),
                          backgroundColor: Colors.orange.shade600,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                product.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                product.body ?? 'No Description',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 16,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Added to Favourites',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContent(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading favourites',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<FavouritesBloc>().add(LoadFavouritesEvent());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
