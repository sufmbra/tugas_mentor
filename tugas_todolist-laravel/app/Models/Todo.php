<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    use HasFactory;

    protected $fillable = [
        'status', // rendah, sedang, tinggi
        'title',
        'description',
        'deadline',
        'label_id',
        'category_id',
    ];

    protected $casts = [
        'deadline' => 'datetime',
    ];

    // ✅ Relasi ke kategori
    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    // ✅ Relasi ke label
    public function label()
    {
        return $this->belongsTo(Label::class);
    }
}
