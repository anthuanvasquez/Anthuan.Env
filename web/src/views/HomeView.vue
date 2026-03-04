<script setup lang="ts">
import { ref, computed } from 'vue'
import ToolCard from '@/components/ToolCard.vue'
import CodeEditorSection from '@/components/CodeEditorSection.vue'
import { setupData, categories } from '@/data/setupData'
import { useTheme } from '@/composables/useTheme'

// Estado para tracking de progreso
const completedTools = ref(new Set<string>())

// Theme composable
const { isDark, toggleTheme } = useTheme()

const totalTools = computed(() => setupData.length)
const completedCount = computed(() => completedTools.value.size)
const progressPercentage = computed(() =>
  totalTools.value > 0 ? Math.round((completedCount.value / totalTools.value) * 100) : 0
)

const getToolsByCategory = (category: string) => {
  return setupData.filter(tool => tool.category === category)
}

const getCategoryIcon = (category: string) => {
  const icons: Record<string, string> = {
    'Initial Setup': '⚙️',
    'Development Tools': '🛠️',
    'Applications': '📱',
    'Code Editor': '💻'
  }
  return icons[category] || '📦'
}

const getCategoryDescription = (category: string) => {
  const descriptions: Record<string, string> = {
    'Initial Setup': 'Configuración básica del sistema y herramientas fundamentales',
    'Development Tools': 'Herramientas esenciales para desarrollo web moderno',
    'Applications': 'Aplicaciones que mejorarán tu flujo de trabajo diario',
    'Code Editor': 'VS Code y extensiones para maximizar tu productividad'
  }
  return descriptions[category] || 'Herramientas para desarrollo'
}

const handleToolCompleted = (toolId: string, completed: boolean) => {
  if (completed) {
    completedTools.value.add(toolId)
  } else {
    completedTools.value.delete(toolId)
  }
}
</script>

<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-950 text-gray-900 dark:text-gray-100 font-sans selection:bg-blue-200 dark:selection:bg-blue-900 transition-colors duration-200">
    <!-- Header -->
    <header class="sticky top-0 z-50 bg-white/80 dark:bg-gray-900/80 backdrop-blur-md border-b border-gray-200 dark:border-gray-800">
      <div class="max-w-7xl mx-auto px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <div class="flex items-center gap-3">
            <div class="text-2xl grayscale">🍎</div>
            <h1 class="text-lg font-semibold tracking-tight">Dotfiles</h1>
          </div>
          <nav class="flex items-center gap-6">
            <a
              v-for="category in categories"
              :key="category"
              :href="`#${category.toLowerCase().replace(/\s+/g, '-')}`"
              class="text-sm font-medium text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100 transition-colors"
            >
              {{ category }}
            </a>
            <!-- Theme Toggle Button -->
            <button
              @click="toggleTheme"
              class="p-2 rounded hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors text-gray-500 dark:text-gray-400"
              :title="isDark ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro'"
            >
              <svg v-if="isDark" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
              </svg>
              <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
              </svg>
            </button>
          </nav>
        </div>
      </div>
    </header>

    <!-- Hero Section -->
    <section class="py-24 sm:py-32">
      <div class="max-w-5xl mx-auto text-center px-6 lg:px-8">
        <div class="mb-8">
          <div class="inline-flex items-center px-3 py-1 rounded-full bg-gray-100 dark:bg-gray-800 border border-gray-200 dark:border-gray-700 text-sm font-medium text-gray-600 dark:text-gray-300">
            <span class="mr-2 grayscale">🚀</span>
            Configuración profesional para desarrolladores
          </div>
        </div>

        <h1 class="text-5xl md:text-7xl font-bold tracking-tight text-gray-900 dark:text-white mb-6">
          Dotfiles
        </h1>

        <p class="text-lg md:text-xl text-gray-500 dark:text-gray-400 mb-10 max-w-2xl mx-auto leading-relaxed">
          Una guía completa e interactiva para configurar tu Mac como un entorno de desarrollo web profesional.
          <span class="text-gray-900 dark:text-gray-200 font-medium">Todas las herramientas esenciales</span> con comandos copiables.
        </p>

        <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <a
            href="#initial-setup"
            class="bg-gray-900 hover:bg-black dark:bg-white dark:hover:bg-gray-100 text-white dark:text-gray-900 px-6 py-3 rounded-lg font-medium transition-colors inline-flex items-center gap-2"
          >
            <span>Comenzar Setup</span>
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5-5 5M6 12h12"></path>
            </svg>
          </a>

          <a
            href="https://github.com/anthuanvasquez/dotfiles"
            target="_blank"
            class="bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600 text-gray-700 dark:text-gray-300 px-6 py-3 rounded-lg font-medium transition-colors inline-flex items-center gap-2"
          >
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
            </svg>
            <span>Ver en GitHub</span>
          </a>
        </div>

        <!-- Statistics -->
        <div class="mt-16 pt-8 border-t border-gray-200 dark:border-gray-800 grid grid-cols-2 md:grid-cols-4 gap-8 max-w-3xl mx-auto">
          <div>
            <div class="text-3xl font-semibold text-gray-900 dark:text-gray-100">{{ totalTools }}</div>
            <div class="text-sm text-gray-500 dark:text-gray-400 mt-1">Herramientas</div>
          </div>
          <div>
            <div class="text-3xl font-semibold text-gray-900 dark:text-gray-100">30+</div>
            <div class="text-sm text-gray-500 dark:text-gray-400 mt-1">Extensiones VS Code</div>
          </div>
          <div>
            <div class="text-3xl font-semibold text-gray-900 dark:text-gray-100">4</div>
            <div class="text-sm text-gray-500 dark:text-gray-400 mt-1">Categorías</div>
          </div>
          <div>
            <div class="text-3xl font-semibold text-gray-900 dark:text-gray-100">100%</div>
            <div class="text-sm text-gray-500 dark:text-gray-400 mt-1">Open Source</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Progress Bar -->
    <div class="max-w-4xl mx-auto px-6 lg:px-8 mb-16">
      <div class="bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-6 flex flex-col sm:flex-row sm:items-center gap-6">
        <div class="flex-1">
          <h3 class="text-base font-semibold text-gray-900 dark:text-gray-100">Progreso del Setup</h3>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">Marca las herramientas que ya tienes instaladas</p>
        </div>
        <div class="flex-1 max-w-sm w-full">
          <div class="flex justify-between text-sm mb-2">
            <span class="text-gray-500 dark:text-gray-400">{{ completedCount }} de {{ totalTools }} completado</span>
            <span class="font-medium text-gray-900 dark:text-gray-100">{{ progressPercentage }}%</span>
          </div>
          <div class="w-full bg-gray-100 dark:bg-gray-800 rounded-full h-2 overflow-hidden border border-gray-200 dark:border-gray-700">
            <div
              class="bg-blue-600 h-full rounded-full transition-all duration-500 ease-out"
              :style="{ width: `${progressPercentage}%` }"
            ></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Content Sections -->
    <main class="max-w-5xl mx-auto px-6 lg:px-8 pb-24">
      <div
        v-for="category in categories"
        :key="category"
        :id="category.toLowerCase().replace(/\s+/g, '-')"
        class="mb-24 scroll-mt-24"
      >
        <div class="flex items-center gap-4 mb-8">
          <div class="text-3xl grayscale">{{ getCategoryIcon(category) }}</div>
          <div>
            <h2 class="text-2xl font-semibold tracking-tight text-gray-900 dark:text-gray-100">{{ category }}</h2>
            <p class="text-gray-500 dark:text-gray-400 mt-1">
              {{ getCategoryDescription(category) }}
            </p>
          </div>
        </div>

        <div class="grid gap-6 md:grid-cols-2">
          <ToolCard
            v-for="tool in getToolsByCategory(category)"
            :key="tool.id"
            :tool="tool"
            @tool-completed="handleToolCompleted"
          />
        </div>
      </div>

      <!-- Code Editor Section -->
      <div id="code-editor" class="mb-24 scroll-mt-24">
        <div class="flex items-center gap-4 mb-8">
          <div class="text-3xl grayscale">💻</div>
          <div>
            <h2 class="text-2xl font-semibold tracking-tight text-gray-900 dark:text-gray-100">Editor de Código</h2>
            <p class="text-gray-500 dark:text-gray-400 mt-1">
              VS Code y todas las extensiones esenciales para desarrollo web
            </p>
          </div>
        </div>
        <CodeEditorSection />
      </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white dark:bg-gray-900 border-t border-gray-200 dark:border-gray-800 py-12">
      <div class="max-w-5xl mx-auto px-6 lg:px-8">
        <div class="flex flex-col md:flex-row justify-between items-center gap-6">
          <div class="flex items-center gap-2">
            <span class="text-xl grayscale">🚀</span>
            <span class="font-medium">Dotfiles</span>
          </div>

          <div class="flex items-center gap-6">
            <a
              href="https://github.com/anthuanvasquez/dotfiles"
              target="_blank"
              class="text-sm text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100 transition-colors"
            >
              GitHub
            </a>
            <a
              href="https://github.com/anthuanvasquez"
              target="_blank"
              class="text-sm text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-gray-100 transition-colors"
            >
              @anthuanvasquez
            </a>
          </div>
        </div>
        <div class="mt-8 pt-8 border-t border-gray-100 dark:border-gray-800/50 flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-gray-400 dark:text-gray-500">
          <p>
            Diseñado para minimizar la fricción visual y técnica.
          </p>
          <p>
            © 2026 Anthuan Vasquez. MIT License.
          </p>
        </div>
      </div>
    </footer>
  </div>
</template>

