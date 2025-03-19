<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Todo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class TodoController extends Controller
{
    // ✅ Ambil semua todos dengan kategori & label
    public function index()
    {
        $todos = Todo::with(['category', 'label'])->get();
        return response()->json($todos);
    }

    // ✅ Simpan todo baru
    public function store(Request $request)
{
    Log::info('Data yang diterima:', $request->all());

    $validated = $request->validate([
        'status' => 'required|in:rendah,sedang,tinggi',
        'title' => 'required|string|max:255',
        'description' => 'nullable|string',
        'deadline' => 'required|date',
        'label_id' => 'required|exists:labels,id',
        'category_id' => 'required|exists:categories,id',
    ]);

    Log::info('Data yang divalidasi:', $validated);

    $todo = Todo::create($validated);
    return response()->json(['message' => 'Todo created successfully', 'data' => $todo], 201);
}



    // ✅ Ambil satu todo berdasarkan ID
    public function show(Todo $todo)
    {
        return response()->json($todo->load(['category', 'label']));
    }

    // ✅ Update todo
    public function update(Request $request, Todo $todo)
    {
        $validated = $request->validate([
            'status' => 'in:rendah,sedang,tinggi',
            'title' => 'string|max:255',
            'description' => 'nullable|string',
            'deadline' => 'date',
            'label_id' => 'exists:labels,id',
            'category_id' => 'exists:categories,id',
        ]);

        $todo->update($validated);
        return response()->json(['message' => 'Todo updated successfully', 'data' => $todo]);
    }

    // ✅ Hapus todo
    public function destroy(Todo $todo)
    {
        $todo->delete();
        return response()->json(['message' => 'Todo deleted successfully']);
    }

    // ✅ Pencarian todo berdasarkan judul
    public function search($keyword)
    {
        $todos = Todo::where('title', 'like', "%$keyword%")->get();
        return response()->json($todos);
    }

    // ✅ Sorting todo berdasarkan skala prioritas
    public function sortByPriority()
    {
        $todos = Todo::orderByRaw("FIELD(status, 'tinggi', 'sedang', 'rendah')")->get();
        return response()->json($todos);
    }

    // ✅ Cek deadline mendekati waktu tertentu (misal 1 hari sebelum deadline)
    public function checkDeadlines()
    {
        $today = Carbon::now();
        $todos = Todo::whereDate('deadline', '<=', $today->addDay())->get();
        return response()->json($todos);
    }
}
