import { DirectiveBinding } from 'vue'
import { useStore } from '../hooks/useStore'

export const permission = {
  mounted(el: HTMLElement, binding: DirectiveBinding) {
    const { isAdmin } = useStore()
    const { value } = binding

    if (value && !value.includes(isAdmin.value ? 'admin' : 'user')) {
      el.parentNode?.removeChild(el)
    }
  }
} 