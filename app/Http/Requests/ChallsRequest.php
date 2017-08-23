<?php

namespace ctf\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ChallsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'nome' => '',
            'flag' => '',
            'autor' => '',
            'pontos' => '',
            'enunciado' => '',
        ];
    }
}
