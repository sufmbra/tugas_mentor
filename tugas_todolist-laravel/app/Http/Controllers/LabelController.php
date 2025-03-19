<?php

namespace App\Http\Controllers;

use App\Models\Label;
use Illuminate\Http\Request;

class LabelController extends Controller
{
    // ✅ Ambil semua label
    public function index()
    {
        return response()->json(Label::all());
    }

    // ✅ Simpan label baru
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
        ]);

        $label = Label::create($validated);
        return response()->json(['message' => 'Label created successfully', 'data' => $label], 201);
    }

    // ✅ Ambil satu label
    public function show(Label $label)
    {
        return response()->json($label);
    }

    // ✅ Update label
    public function update(Request $request, Label $label)
    {
        $validated = $request->validate([
            'title' => 'string|max:255',
        ]);

        $label->update($validated);
        return response()->json(['message' => 'Label updated successfully', 'data' => $label]);
    }

    // ✅ Hapus label
    public function destroy(Label $label)
    {
        $label->delete();
        return response()->json(['message' => 'Label deleted successfully']);
    }
}
