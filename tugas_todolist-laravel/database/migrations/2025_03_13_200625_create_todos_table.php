<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('todos', function (Blueprint $table) {
            $table->id();
            $table->enum('status', ['rendah', 'sedang', 'tinggi']);
            $table->string('title');
            $table->text('description');
            $table->dateTime('deadline');
            $table->unsignedBigInteger('label_id'); // Foreign key belum dibuat
            $table->unsignedBigInteger('category_id'); // Foreign key belum dibuat
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('todos');
    }
};
