do this before u run my project
1. go to laravel project
2. type "cp .env.example .env"
3. type "composer update"
4. type "php artisan key:generate"
5. type "php artisan migrate"
6. type "php artisan tinker"
7. fill with
\App\Models\Label::all();
\App\Models\Category::all();
8. fill with  
\App\Models\Label::create(['title' => 'Penting']);
\App\Models\Category::create(['title' => 'Kerjaan']);
