<template>
  <div class="group relative bg-white dark:bg-gray-900 rounded-xl border border-gray-200 dark:border-gray-800 p-6 hover:border-gray-300 dark:hover:border-gray-700 transition-colors duration-200">
    <div class="relative flex items-start gap-5">
      <div class="flex flex-col items-center gap-4">
        <div class="text-3xl grayscale group-hover:grayscale-0 transition-all duration-300">{{ tool.icon }}</div>
        <!-- Progress Checkbox -->
        <label class="flex items-center cursor-pointer group/checkbox">
          <input
            type="checkbox"
            :checked="isCompleted"
            @change="toggleCompleted"
            class="sr-only"
          >
          <div class="relative">
            <div class="w-5 h-5 border rounded transition-colors duration-200 flex items-center justify-center"
                 :class="isCompleted
                   ? 'bg-blue-600 border-blue-600'
                   : 'bg-transparent border-gray-300 dark:border-gray-600 group-hover/checkbox:border-gray-400 dark:group-hover/checkbox:border-gray-500'">
              <svg
                v-if="isCompleted"
                class="w-3 h-3 text-white"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path>
              </svg>
            </div>
          </div>
        </label>
      </div>

      <div class="flex-1 min-w-0">
        <div class="flex items-start justify-between mb-2">
          <div class="flex items-center gap-3 flex-1">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors duration-200">
              {{ tool.name }}
            </h3>
            <a
              v-if="tool.url"
              :href="tool.url"
              target="_blank"
              rel="noopener noreferrer"
              class="flex-shrink-0 p-1 rounded text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors duration-200"
              title="Abrir sitio oficial"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
              </svg>
            </a>
          </div>
        </div>

        <p class="text-sm text-gray-500 dark:text-gray-400 mb-5 leading-relaxed">{{ tool.description }}</p>

        <!-- Commands Section -->
        <div class="space-y-2 mb-5">
          <div v-for="(command, index) in tool.commands" :key="index" class="relative group/command">
            <div class="bg-gray-50 dark:bg-gray-950 rounded p-3 text-sm font-mono text-gray-800 dark:text-gray-300 flex items-center justify-between border border-gray-200 dark:border-gray-800/60 transition-colors duration-200">
              <code class="flex-1 pr-3 break-all">{{ command }}</code>
              <button
                @click="copyToClipboard(command)"
                class="flex-shrink-0 p-1.5 rounded hover:bg-gray-200 dark:hover:bg-gray-800 transition-colors duration-200 opacity-0 group-hover/command:opacity-100 text-gray-400 hover:text-gray-700 dark:hover:text-gray-200"
                title="Copiar comando"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
              </button>
            </div>
          </div>
        </div>

        <!-- Notes Section -->
        <div v-if="tool.notes && tool.notes.length > 0" class="space-y-2">
          <div v-for="(note, index) in tool.notes" :key="index" class="relative group/note">
            <div class="bg-blue-50/50 dark:bg-blue-900/10 border-l-2 border-blue-400 dark:border-blue-500 p-3 text-sm font-mono text-blue-800 dark:text-blue-300 flex items-center justify-between rounded-r transition-colors duration-200">
              <code class="flex-1 pr-3 break-all">{{ note }}</code>
              <button
                @click="copyToClipboard(note)"
                class="flex-shrink-0 p-1.5 rounded hover:bg-blue-100 dark:hover:bg-blue-800/30 transition-colors duration-200 opacity-0 group-hover/note:opacity-100 text-blue-400 hover:text-blue-600 dark:hover:text-blue-200"
                title="Copiar nota"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { Tool } from '@/data/setupData'

const props = defineProps<{
  tool: Tool
}>()

const emit = defineEmits<{
  'tool-completed': [toolId: string, completed: boolean]
}>()

const isCompleted = ref(false)

const toggleCompleted = () => {
  isCompleted.value = !isCompleted.value
  emit('tool-completed', props.tool.id, isCompleted.value)
}

const copyToClipboard = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text)
  } catch (err) {
    console.error('Failed to copy text: ', err)
  }
}
</script>
