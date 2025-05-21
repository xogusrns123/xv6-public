        .text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
        .globl thread_switch
thread_switch:
        pushal                          # save all registers
        movl current_thread, %eax       # eax = &current_thread
        movl %esp, (%eax)               # save esp to current_thread->sp

        movl next_thread, %eax          # eax = next_thread
        movl %eax, current_thread       # current_thread = next_thread
        movl (%eax), %esp               # switch to next thread stack
        movl $0, next_thread            # clear next_thread

        popal                           # restore registers of new thread
        ret                             # return to next thread
