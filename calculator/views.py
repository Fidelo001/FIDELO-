from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
import json


def calculator(request):
    """Render the calculator page"""
    return render(request, 'calculator/calculator.html')


@require_http_methods(["POST"])
def calculate(request):
    """Process calculator operations"""
    try:
        data = json.loads(request.body)
        operation = data.get('operation')
        num1 = float(data.get('num1', 0))
        num2 = float(data.get('num2', 0))
        
        result = None
        
        if operation == 'add':
            result = num1 + num2
        elif operation == 'subtract':
            result = num1 - num2
        elif operation == 'multiply':
            result = num1 * num2
        elif operation == 'divide':
            if num2 == 0:
                return JsonResponse({'error': 'Cannot divide by zero'}, status=400)
            result = num1 / num2
        elif operation == 'power':
            result = num1 ** num2
        elif operation == 'square_root':
            if num1 < 0:
                return JsonResponse({'error': 'Cannot calculate square root of negative number'}, status=400)
            result = num1 ** 0.5
        else:
            return JsonResponse({'error': 'Invalid operation'}, status=400)
        
        return JsonResponse({'result': result})
    
    except (ValueError, TypeError) as e:
        return JsonResponse({'error': 'Invalid input'}, status=400)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
