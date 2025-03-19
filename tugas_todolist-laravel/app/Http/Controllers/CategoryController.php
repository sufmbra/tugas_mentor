<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    // ✅ Ambil semua kategori
    public function index()
    {
        return response()->json(Category::all());
    }

    // ✅ Simpan kategori baru
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
        ]);

        $category = Category::create($validated);
        return response()->json(['message' => 'Category created successfully', 'data' => $category], 201);
    }

    // ✅ Ambil satu kategori
    public function show(Category $category)
    {
        return response()->json($category);
    }

    // ✅ Update kategori
    public function update(Request $request, Category $category)
    {
        $validated = $request->validate([
            'title' => 'string|max:255',
        ]);

        $category->update($validated);
        return response()->json(['message' => 'Category updated successfully', 'data' => $category]);
    }

    // ✅ Hapus kategori
    public function destroy(Category $category)
    {
        $category->delete();
        return response()->json(['message' => 'Category deleted successfully']);
    }
}
