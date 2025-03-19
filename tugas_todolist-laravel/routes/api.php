<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TodoController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\LabelController;
use App\Http\Middleware\CorsMiddleware;

Route::options('/{any}', function () {
    return response()->json();
})->where('any', '.*');

Route::middleware([CorsMiddleware::class])->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    })->middleware('auth:sanctum');

    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

    Route::middleware('auth:sanctum')->group(function () {
        // Routes for Todos
        Route::get('/todos', [TodoController::class, 'index']);
        Route::post('/todos', [TodoController::class, 'store']);
        Route::get('/todos/{todo}', [TodoController::class, 'show']);
        Route::put('/todos/{todo}', [TodoController::class, 'update']);
        Route::delete('/todos/{todo}', [TodoController::class, 'destroy']);
        Route::get('/todos/search/{keyword}', [TodoController::class, 'search']);
        Route::get('/todos/sort/prioritas', [TodoController::class, 'sortByPriority']);
        Route::get('/todos/check-deadlines', [TodoController::class, 'checkDeadlines']);

        // Routes for Categories
        Route::get('/categories', [CategoryController::class, 'index']);
        Route::post('/categories', [CategoryController::class, 'store']);
        Route::get('/categories/{category}', [CategoryController::class, 'show']);
        Route::put('/categories/{category}', [CategoryController::class, 'update']);
        Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);

        // Routes for Labels
        Route::get('/labels', [LabelController::class, 'index']);
        Route::post('/labels', [LabelController::class, 'store']);
        Route::get('/labels/{label}', [LabelController::class, 'show']);
        Route::put('/labels/{label}', [LabelController::class, 'update']);
        Route::delete('/labels/{label}', [LabelController::class, 'destroy']);
    });
});
